require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe RegistrationsController, type: :controller do
  let(:user) { build(:user) }

  let(:valid_attributes) {
    { email: user.email, username: user.username, password: user.password }
  }

  let(:invalid_attributes) {
    { email: "example_example.com", username: "w1ll", password: "pass" }
  }

  context 'when attributes are correct' do
    it 'renders status 200' do
      post :create, params: { user: valid_attributes }, format: :json

      json = JSON.parse(response.body)

      expect(json["status"]).to eq 200
      expect(json["user"]["username"]).to include valid_attributes[:username]
    end
  end

  context 'when attributes are incorrect' do
    it 'renders status 401' do
      post :create, params: { user: invalid_attributes }, format: :json

      json = JSON.parse(response.body)

      expect(json["status"]).to eq 401
    end
  end

end
