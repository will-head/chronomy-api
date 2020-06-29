require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create!(email: "example@example.com", username: "example", password: "password") }
  it { is_expected.to be }

  context 'when correct attributes' do
    it 'User is valid' do
      user = User.create(username: 'example20', email: 'email@example.com', password: 'password')

      expect(user).to be_valid
    end
  end

  context 'when incorect attributes' do
    it 'User is not valid with no username' do
      user = User.create(username: nil, email: 'email@example.com', password: 'password')

      expect(user).to_not be_valid
    end

    it 'User is not valid with no email' do
      user = User.create(username: 'example20', email: nil, password: 'password')

      expect(user).to_not be_valid
    end

    it 'User is not valid with no password' do
      user = User.create(username: 'example20', email: 'email@example.com', password: nil)

      expect(user).to_not be_valid
    end
  end

  context 'when the username is not unique' do
    it 'user is not created' do
      User.create(username: 'example20', email: 'email@example.com', password: 'password')
      user = User.create(username: 'example20', email: 'another_email@example.com', password: 'another_password')

      expect(user).to_not be_valid
    end
  end

  context 'when the email is not unique' do
    it 'user is not created' do
      User.create(username: 'example20', email: 'email@example.com', password: 'password')
      user = User.create(username: 'another_example20', email: 'email@example.com', password: 'another_password')

      expect(user).to_not be_valid
    end
  end

  context 'when the email has the wrong format' do
    it 'user is not created' do
      user = User.create(username: 'example20', email: 'email-example.com', password: 'password')

      expect(user).to_not be_valid
    end
  end

  context 'when the password length < 6' do
    it 'user is not created' do
      user = User.create(username: 'example20', email: 'email@example.com', password: 'passw')

      expect(user).to_not be_valid
    end
  end
end
