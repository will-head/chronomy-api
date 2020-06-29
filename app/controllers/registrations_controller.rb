class RegistrationsController < ApplicationController

  def create
    user = User.create!(
      email: params['user']['email'],
      username: params['user']['username'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation']
      )

    if user
      session[:user_id] = user.id 
      render json: {
        status: 200,
        user: user 
      }
    else
      render json: { status: 500 }
    end

  end

end
