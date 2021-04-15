class ImportFile < ApplicationRecord
    include AASM
    belongs_to :user

    aasm column: 'state' do
      state :waiting, initial: true
      state :processing
      state :failed
      state :finished
  
      event :process do
        transitions from: :waiting, to: :processing
      end

      event :finish do
        transitions from: :processing, to: :finished
      end
  
      event :fail do
        transitions from: :processing, to: :failed
      end
  
    end

    def import(file, user)
        valid = 0
        CSV.foreach(file.path, headers: true) do |row|
          contact_hash = row.to_hash
          contact = Contact.new(name: contact_hash['name'], telephone: contact_hash['telephone'],
                                      email: contact_hash['email'], address: contact_hash['address'],
                                      birthday: contact_hash['birthday'],
                                      credit_card_number: contact_hash['credit_card_number'],
                                      credit_card_franchise: contact_hash['credit_card_number'].credit_card_brand_name,
                                      credit_card_last_four_digits: contact_hash['credit_card_number'],
                                      user_id: user.id)
          if contact.save
            valid = 1
          else
            invalid_contact = InvalidContact.new(name: contact_hash['name'],
                              telephone: contact_hash['telephone'],
                              email: contact_hash['email'], address: contact_hash['address'],
                              birthday: contact_hash['birthday'],
                              credit_card_number: contact_hash['credit_card_number'],
                              credit_card_franchise: contact_hash['credit_card_number'].credit_card_brand_name,
                              credit_card_last_four_digits: contact_hash['credit_card_number'],
                              user_id: user.id, error_message: contact.errors.full_messages.join(', '))
            invalid_contact.save
          end
          process! if may_process?
          end
          if valid == 1
            finish!
          else
            fail!
          end
    end
end
