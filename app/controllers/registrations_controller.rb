class RegistrationsController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      render json: { status: 200, user: user }
    else
      render json: { status: 401 }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
