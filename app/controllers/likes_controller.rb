class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @likeable_item = find_likeable
    @like = Like.build(user: current_user, likeable: @likeable_item)

    if @like.save
      redirect_back fallback_location: root_path
    else
      puts @like.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.user == current_user
      @like.destroy
    end

    redirect_back fallback_location: root_path
  end

  private
  def find_likeable
    if params[:post_id]
      Post.find(params[:post_id])
    end
  end
end
