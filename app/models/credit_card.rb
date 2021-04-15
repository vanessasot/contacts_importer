class CreditCard < ApplicationRecord
    def initialize(credit_card_num)
        @credit_card = credit_card_num
    end
    
    def four_digits
        @credit_card.last(4).to_s
    end
    
    def encryption_credit_card
        BCrypt::Password.create(@credit_card)
    end
end
