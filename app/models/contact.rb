class Contact < ApplicationRecord
    validates :name, :birthday, :telephone, :address, :credit_card_number,
              :credit_card_franchise, :email, presence: true
end
