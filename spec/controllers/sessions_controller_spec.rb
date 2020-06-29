require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create!(email: "example@example.com", username: "example", password: "password") }

  let(:valid_attributes) {
    { email: user.email, username: user.username, password: "password" }
  }

  let(:invalid_attributes) {
    { email: user.email, username: user.username, password: "wordpass" }
  }

  let(:valid_session) { {} }

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "renders a JSON response with the new session" do
  #       post :create, params: { session: valid_attributes }, session: valid_session
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to eq('application/json')
  #       expect(JSON.parse(response.body)).to eq(
  #         "session_key" => User.last.session_key,
  #         "user_id" => User.last.id
  #       )
  #     end
  #   end
  # end

end
