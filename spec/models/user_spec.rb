require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#validations' do
    let(:user) {User.new()}

    it 'without email for the user' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'with invalid email for the user' do
      user.email = "name@gmail"
      expect(user).not_to be_valid
    end

    it 'when another user has a duplicated email' do
      user2 = User.new
      user2.email = "email@gmail.com"
      user.email = "email@gmail.com"
      expect(user).not_to be_valid
    end

    it 'without password for the user' do
      user.password = nil
      expect(user).not_to be_valid
    end

    it 'without password confirmation for the user' do
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'with wrong password confirmation for the user' do
      user.password = "pass00"
      user.password_confirmation="pass01"
      expect(user).not_to be_valid
    end

  end
end
