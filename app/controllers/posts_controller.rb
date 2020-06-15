class PostsController < ApplicationController

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new
    @comment.post_id = @post.id
    @user_name = @user.first_name + " " + @user.last_name
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

  def friend_feed
    @user_friends = current_user.friends
  end

  def create_like
    @post = Post.find(params[:id])

    post_likes = @post.likes
    user_likes = Like.find_by(user_id: current_user.id, post_id: @post.id)

    if post_likes.include?(user_likes)
      redirect_back(fallback_location: { controller: "post", action: "show"})
    else
      Post.find(@post.id).likes.create!(user_id: current_user.id, post_id: @post.id)
      redirect_back(fallback_location: { controller: "post", action: "show"})
    end
  end

  def destroy_like
    @post = Post.find(params[:id])

    post_likes = @post.likes
    user_likes = Like.find_by(user_id: current_user.id, post_id: @post.id)

    if post_likes.include?(user_likes)
      user_likes.destroy
      redirect_back(fallback_location: { controller: "post", action: "show"})
    else
      redirect_back(fallback_location: { controller: "post", action: "show"})
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
