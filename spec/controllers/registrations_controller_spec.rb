require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe RegistrationsController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) {
    { email: user.email, username: user.username, password: "password" }
  }

  context 'when attributes are correct' do
    it 'renders status 200' do
      post :create, params: { user: valid_attributes }, as: :json

      json = JSON.parse(response.body)
      p response.body
      p json

      expect(response).to have_http_status 200
      expect(json["user"]["username"]).to include valid_attributes[:username]
    end
  end

end
