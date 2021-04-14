class UsersContact < ApplicationRecord
  belongs_to :user
  belongs_to :contact
  validates :user_id, presence: true
  validates :contact_id, presence: true
end
