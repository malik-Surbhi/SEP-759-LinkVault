# frozen_string_literal: true

class ApiTokenStrategy < Warden::Strategies::Base
  def valid?
    api_token.present? || (email.present? && password.present?)
  end

  def authenticate!
    Rails.logger.debug("ApiTokenStrategy: authenticate? method called")

    if api_token.present?
      user = User.find_by(api_token: api_token)
    elsif email.present? && password.present?
      user = User.find_by(email: email)
      user = nil unless user&.valid_password?(password)
    end

    if user
      success!(user)
    else
      fail!('Invalid email or password')
    end
  end

  private

  def api_token
    Rails.logger.debug("ApiTokenStrategy: api_token? method called")
    Rails.logger.debug(env['HTTP_AUTHORIZATION'])
    env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
  end

  def email
    params['email'] || params['user'] && params['user']['email']
  end

  def password
    params['password'] || params['user'] && params['user']['password']
  end
end
