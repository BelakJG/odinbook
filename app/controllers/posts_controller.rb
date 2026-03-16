class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    edited_params = post_params.merge(edited: true)
    if @post.update(edited_params)
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
