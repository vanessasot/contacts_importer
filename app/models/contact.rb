class Contact < ApplicationRecord
    belongs_to :user

    VALID_NAME = /\A[a-zA-Z\s-]+\z/
    VALID_TELEPHONE = /\A(\(\+\d{2}\)[\s]\d{3}[\s]\d{3}[\s]\d{2}[\s]\d{2})|(\(\+\d{2}\)[\s]\d{3}[-]\d{3}[-]\d{2}[-]\d{2})\z/
    VALID_EMAIL = /\A[^@\s]+@[^@\s]+\z/

    validates :name, :birthday, :telephone, :address, :credit_card_number,
              :credit_card_franchise, :email, presence: true

    validates :name, format: { with: VALID_NAME, message: "Name can't have special characters except -" }
    
    validate :date_valid
    
    validates :telephone, format: { with: VALID_TELEPHONE,
              message: "(+00) 000 000 00 00 and (+00) 000-000-00-00 are the only telephone formats permitted" }
    
    #validates :credit_card_number, credit_card_number: true
    
    validates :email, uniqueness: { scope: :user_id, message: "You can't have two contacts with the same email"  },
              format: { with: VALID_EMAIL, message: "Must be a valid email address" }

    validate :get_last_digits

    after_validation :credit_card_encrypt

    def date_valid
        Date.iso8601(birthday)
    rescue StandardError
        errors.add(:birthday, "Only formats YYYYMMDD and YYYY-MM-DD are allowed")
    end

    def get_last_digits
      self.credit_card_last_four_digits = CreditCard.new(credit_card_last_four_digits).four_digits
    end
    
    def credit_card_encrypt 
      self.credit_card_number = CreditCard.new(credit_card_number).encryption_credit_card
    end
end
