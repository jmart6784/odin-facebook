class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

    if @friendship.save
      redirect_to users_path
    else
      redirect_to users_path
    end
  end

  def update
    @friendship = Friendship.where(user_id:params[:id]).where(friend_id:current_user).first
    if @friendship.confirmed!
      current_user.friendships.find_or_initialize_by(:friend_id => params[:id]).confirmed!
    end

    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.where(user_id:params[:id]).where(friend_id:current_user).first
    @friendship.destroy

    redirect_to users_path
  end

  def notifications
    
  end
end
