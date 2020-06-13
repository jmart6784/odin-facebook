class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new
    @comment.post_id = @post.id
    @likes = @post.likes

    post_likes = @post.likes
    user_likes = current_user.posts.find(@post.id).likes.first
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash.notice = "Successfully created a Post!"
      redirect_to @post
    else 
      flash.now[:danger] = "Can't create this Post, there are errors."
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.update(post_params)
    flash.notice = "Post '#{@post.title}' was updated!"
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash.notice = "Post '#{@post.title}' was deleted!"
    redirect_to posts_path
  end

  def create_like
    @post = Post.find(params[:id])

    post_likes = @post.likes
    user_likes = current_user.posts.find(@post.id).likes.first

    if post_likes.include?(user_likes)
      redirect_back(fallback_location: { controller: "post", action: "show"})
    else
      @post.likes.create!(user_id: current_user.id, post_id: @post.id)
      redirect_back(fallback_location: { controller: "post", action: "show"})
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
