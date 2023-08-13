# class SessionsController < ApplicationController
#   skip_before_action :ensure_login,  only: [:new, :create]
#   before_action :redirect_if_logged_in, only: [:new]
#
#   def new
#   end
#
#   def create
#     user = User.find_by(username: params[:user][:username])
#     password = params[:user][:password]
#
#     if user.nil? || password.nil?
#       redirect_to login_path, alert: 'Username/Password Required'
#     elsif user && user.authenticate(password)
#       session[:user_id] = user.id
#       redirect_to root_path, notice: 'Logged In Successfully'
#     else
#       redirect_to login_path, alert: 'Invalid Username/Password. Please try again'
#     end
#   end
#
#   def destroy
#     reset_session
#     redirect_to login_path, notice: 'You have been logged out. Please login to use the app again!'
#   end
#
#   def redirect_if_logged_in
#     redirect_to links_path if logged_in?
#   end
#
# end
