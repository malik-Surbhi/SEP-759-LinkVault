# frozen_string_literal: true

class Api::SessionsController < ApiController

  def create
    user = warden.authenticate!(:api_token)
    if user
      render json: { user: user, api_token: user.api_token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
