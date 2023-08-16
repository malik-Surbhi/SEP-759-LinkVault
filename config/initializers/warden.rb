# frozen_string_literal: true

Rails.application.config.middleware.use Warden::Manager do |manager|

  Warden::Strategies.add(:api_token, ApiTokenStrategy)

end