class LikesController < ApplicationController
    before_action :find_link, only: [:create, :destroy]

    def show
      @liked_links = current_user.likes.map(&:link)
    end

    def liked_links
      @liked_links = current_user.likes.map(&:link)
    end

    def create
      @like = @link.build_like(user: current_user)

      if @like.save
        respond_to do |format|
          format.html { redirect_to @link, notice: 'Link liked successfully.' }
          format.json { render json: { success: true, message: 'Link liked successfully.' } }
        end
      else
        respond_to do |format|
          format.html { redirect_to @link, alert: 'Unable to like the link.' }
          format.json { render json: { success: false, error: 'Unable to like the link.' }, status: :unprocessable_entity }
        end
      end
    end

    def destroy

      @link.like&.destroy

      respond_to do |format|
        format.html { redirect_to @link, notice: 'Link unliked successfully.' }
        format.json { render json: { success: true, message: 'Link unliked successfully.' } }
      end
    end

    private

    def find_link
      @link = Link.find(params[:link_id])
    end

    private

    def like_params
      params.require(:like).permit(:link_id)
    end

end
