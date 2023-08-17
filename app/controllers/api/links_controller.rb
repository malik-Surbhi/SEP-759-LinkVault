# frozen_string_literal: true

class Api::LinksController < Api::AuthApiController

  # before_action :authenticate_user!

  def index
    links = current_user.links
    rendered_links = links.map { |link| { id: link.id, url: link.url, title: link.title } }
    render json: rendered_links
  end

  def create
    link = current_user.links.new(link_params)
    if link.save
      render json: link, status: :created
    else
      render json: link.errors, status: :unprocessable_entity
    end
  end

  def show
    # warden.authenticate!(:api_token)
    link = Link.find(params[:id])
    if link
      render json: link
    else
      render json: {error: 'No Link found'}, status: 404
    end
  end

  def update
    link = current_user.links.find(params[:id])

    if link.update(link_params)
      render json: link, status: :ok
    else
      render json: link.errors, status: :unprocessable_entity
    end
  end

  def destroy
    link = current_user.links.find(params[:id])

    if link.destroy
      render json: { message: "Link deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete link" }, status: :unprocessable_entity
    end
  end


  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
