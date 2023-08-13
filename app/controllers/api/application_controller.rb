# frozen_string_literal: true
module Api
  class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password_confirmation, :bio, :email, :profile_photo])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :bio])
    end
  end
end

