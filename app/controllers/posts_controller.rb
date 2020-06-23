class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comment = Comment.new
    @comment.post_id = @post.id
    @user_name = @user.first_name + " " + @user.last_name
    @post_comments = @post.comments.order("created_at DESC").paginate(page: params[:page], per_page: 10)
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
    @post_ary = []
    @user_friends = current_user.friends

    @user_friends.each do |friend|
      next if Friendship.where(status: "pending", friend_id: friend.id).exists?

      friend.posts.each do |unsorted_posts|
        @post_ary << unsorted_posts
      end
    end

    @paged_and_sorted = @post_ary.sort_by(&:created_at).reverse!.paginate(page: params[:page], per_page: 10)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    if Post.find(params[:id]).user != current_user
      redirect_to posts_path
    end
  end
end
