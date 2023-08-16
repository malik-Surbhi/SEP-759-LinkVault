# frozen_string_literal: true

class Api::AuthApiController < ApiController
  before_action :check_auth

  def check_auth
    warden.authenticate!(:api_token)
  end
end
