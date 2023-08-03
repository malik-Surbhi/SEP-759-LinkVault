class UsersController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  before_action :require_admin, only: [:view]

  def index
  end

  def view
    @users = User.where.not(id: current_user.id)
    # @users = User.joins(:user_roles).where(user_roles: { role_id: Role.find_by(name: 'user').id })
  end

  def show
    @user = User.find(params[:id])

    # Check if the requested format is an image format
    if request.format.in?(%w[jpg png jpeg heic])
      display_profile_photo(request.format)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # User registration successful, redirect to a different page or show a flash message
      redirect_to login_path, notice: 'User registration successful!'
    else
      # If user creation fails, render the new user page again to show the errors
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        if params[:user][:profile_photo].present?
          @user.profile_photo.attach(params[:user][:profile_photo])
        end
        format.html { redirect_to @user, notice: "Profile successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def update_role

    user = User.find(params[:user_id])
    admin = current_user # This is the admin changing the role

    if user.admin?
      user.user_roles.find_by(role: Role.find_by(name: 'admin')).destroy
      user.assign_default_role
      notice_message = "#{user.username} is no longer an admin."
    else
      user.user_roles.create(role: Role.find_by(name: 'admin'))
      notice_message = "#{user.username} has been made an admin."
    end

    redirect_to view_user_path(admin.id), notice: notice_message
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :profile_photo, :bio)
  end

  private

  def display_profile_photo(content_type)
    if @user.profile_photo.attached?
      send_data @user.profile_photo.download, type: content_type, disposition: 'inline'
    else
      send_file Rails.root.join('app', 'assets', 'images', 'placeholder.jpg'), type: content_type, disposition: 'inline'
    end
  end

  def require_admin
    admin_role = Role.find_by(name: 'admin')
    redirect_to root_path unless current_user.user_roles.exists?(role: admin_role)
  end

end
