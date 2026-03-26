class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if current_user.update(user_params)
        redirect_to current_user, notice: "Avatar updated!"
      else
        render :edit
      end
    end
  end

  def follow
    user = User.find(params[:id])
    current_user.follow(user)
    redirect_to user
  end

  def unfollow
    user = User.find(params[:id])
    current_user.unfollow(user)
    redirect_to user
  end

  private
  def user_params
    params.require(:user).permit(:id, :avatar)
  end
end
