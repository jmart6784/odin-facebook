class UsersController < ApplicationController
  def index
    @users = User.all.order("created_at DESC").paginate(page: params[:page], per_page: 16)
  end

  def show
    @user = User.find(params[:id])
    @users_posts = @user.posts.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def friend_list
    
  end
end