class Contact < ApplicationRecord
    belongs_to :user

    validates :name, :birthday, :telephone, :address, :credit_card_number,
              :credit_card_franchise, :email, presence: true

    validates :name, format: { with: /\A[a-zA-Z\s-]+\z/, message: "Name can't have special characters" }
    
    validate :date_valid
    
    validates :telephone,
              format: { with: /\A(\(\+\d{2}\)[\s]\d{3}[\s]\d{3}[\s]\d{2}[\s]\d{2})|(\(\+\d{2}\)[\s]\d{3}[-]\d{3}[-]\d{2}[-]\d{2})\z/,
              message: "(+00) 000 000 00 00 and (+00) 000-000-00-00 are the only telephone formats permitted" }
    
    validates :credit_card_number, credit_card_number: true
    
    validates :email, uniqueness: { scope: :user_id, message: "You can't have two contacts with the same email"  },
              format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address" }


    def date_valid
        Date.iso8601(birthday)
        rescue StandardError
            errors.add(:birthday, "Only formats YYYYMMDD and YYYY-MM-DD are allowed")
    end

    def self.import(file, user)
        CSV.foreach(file.path, headers: true) do |row|
            contact_hash = row.to_hash
            contact = find_or_create_by!(name: contact_hash['name'], telephone: contact_hash['telephone'],
                                         email: contact_hash['email'], address: contact_hash['address'],
                                         birthday: contact_hash['birthday'],
                                         credit_card_number: contact_hash['credit_card_number'],
                                         credit_card_franchise: contact_hash['credit_card_number'].credit_card_brand_name,
                                         user: user.id)
            contact.update(contact_hash)
        end
    end
end
