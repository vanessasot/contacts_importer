class InvalidContact < ApplicationRecord
  belongs_to :user

  validates :error_message, presence: true

  validate :get_last_digits

  def get_last_digits
    self.credit_card_last_four_digits = CreditCard.new(credit_card_last_four_digits).four_digits
  end
end
