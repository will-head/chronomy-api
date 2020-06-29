class StaticController < ApplicationController
  def home
    render json: { status: "Automatically deployed to Heroku, Environment: #{Rails.env}" }
  end
end
