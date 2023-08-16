class UserMailer < ApplicationMailer

  def role_updated_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Your Role Has Been Updated')
  end

end
