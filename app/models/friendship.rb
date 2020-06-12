class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  before_destroy :inverse_destroy

  enum status: [:pending, :confirmed]

  validates_uniqueness_of :user_id, scope: [:friend_id]


  private

  def inverse_destroy
    friendship = friend.friendships.find_by(friend: user)
    friendship.delete if friendship
  end
end
