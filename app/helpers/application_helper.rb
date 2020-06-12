module ApplicationHelper
  def notifications
    Friendship.all.where(friend_id: current_user).where(status: "pending")
  end
end
