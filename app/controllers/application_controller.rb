class ApplicationController < ActionController::Base
        # include DeviseTokenAuth::Concerns::SetUserByToken

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :ensure_login

  helper_method :logged_in?, :current_user, :admin?

  protected
  def ensure_login
    redirect_to new_user_session_path unless session[:user_id]
  end

  def logged_in?
    session[:user_id]
  end

  def admin?
    current_user&.roles&.exists?(name: 'admin')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :password_confirmation, :bio, :email, :profile_photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :bio])
  end

end
