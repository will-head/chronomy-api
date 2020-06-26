require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create!(email: "example@example.com", username: "example", password: "password") }
  it { is_expected.to be }
  
end
