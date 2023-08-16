# frozen_string_literal: true

class Api::RegistrationsController < ApiController

  def create
    user = User.new(user_params)

    if user.save

      if params[:user][:profile_photo]
        user.profile_photo.attach(params[:user][:profile_photo])
      end

      render json: { user: user, api_token: user.api_token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :bio, :profile_photo)
  end

end
