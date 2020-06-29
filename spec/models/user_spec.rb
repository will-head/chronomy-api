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
    end
  end
end
