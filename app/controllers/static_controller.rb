class StaticController < ApplicationController
  def home
    render json: { status: "Automatically deployed to Heroku" }
  end
end
