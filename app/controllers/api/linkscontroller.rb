# frozen_string_literal: true

class Api::LinksController < ApiController

  before_action :authenticate_user!

  def index
    links = current_user.links
    render json: links
  end

  def create
    link = current_user.links.new(link_params)
    if link.save
      render json: link, status: :created
    else
      render json: link.errors, status: :unprocessable_entity
    end
  end

  # Other actions as needed

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
