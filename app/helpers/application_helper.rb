module ApplicationHelper
  def notifications
    Friendship.all.where(friend_id: current_user).where(status: "pending")
  end

  def user_avatar(user, size=40)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize: "#{size}x#{size}!"))
    else
      image_tag("default_profile.jpg", width: "#{size}", height: "#{size}")
    end
  end
end
