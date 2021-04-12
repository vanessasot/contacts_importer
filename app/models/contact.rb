class Contact < ApplicationRecord
    validates :name, :birthday, :telephone, :address, :credit_card_number,
              :credit_card_franchise, :email, presence: true

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            contact_hash = row.to_hash
            contact = find_or_create_by!(name: contact_hash['name'], telephone: contact_hash['telephone'],
                                         email: contact_hash['email'], address: contact_hash['address'],
                                         birthday: contact_hash['birthday'],
                                         credit_card_number: contact_hash['credit card number'],
                                         credit_card_franchise: contact_hash['credit card franchise'])
            contact.update(contact_hash)
        end
    end
end
