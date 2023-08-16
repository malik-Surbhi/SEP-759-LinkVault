# frozen_string_literal: true

class Api::UsersController < ApiController
  # def show
  #   user = User.find(params[:id])
  #   render json: user, status: :ok
  # rescue ActiveRecord::RecordNotFound
  #   render json: { error: "User not found" }, status: :not_found
  # end
  def show
    warden.authenticate!(:api_token)
    render json: current_user.to_json
  end
end

