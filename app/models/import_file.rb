class ImportFile < ApplicationRecord
    belongs_to :user

    def import(file, user)
        CSV.foreach(file.path, headers: true) do |row|
          contact_hash = row.to_hash
          contact = Contact.new(name: contact_hash['name'], telephone: contact_hash['telephone'],
                                      email: contact_hash['email'], address: contact_hash['address'],
                                      birthday: contact_hash['birthday'],
                                      credit_card_number: contact_hash['credit_card_number'],
                                      credit_card_franchise: contact_hash['credit_card_number'].credit_card_brand_name,
                                      credit_card_last_four_digits: contact_hash['credit_card_number'],
                                      user_id: user.id)
          contact.save
        end
      end
end
