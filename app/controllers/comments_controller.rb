class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id

    @comment.save

    redirect_to post_path(@comment.post)
  end

  def edit
    # @post = Post.find(params[:id])
    # @comment = Comment.find(params[:comment_id])
    # @comment = @post.comment_id
    # @comment.post_id = @post
  end

  def update
    
  end

  def destroy
    
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end