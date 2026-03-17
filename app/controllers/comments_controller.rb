class CommentsController < ApplicationController
  before_action :set_comment, only: [ :show, :destroy ]

  def index
    @parent = find_parent
    @comments = @parent.comments.order(created_at: :desc)
  end

  def show
    @parent = @comment.commentable
  end

  def new
    @parent = find_parent
    @comment = @parent.comments.build
  end

  def create
    @parent = find_parent
    @comment = @parent.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @parent = @comment.commentable
    @comment.destroy
    redirect_to @parent
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_parent
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    else
      raise ActiveRecord::RecordNotFound, "No parent found"
    end
  end
end
