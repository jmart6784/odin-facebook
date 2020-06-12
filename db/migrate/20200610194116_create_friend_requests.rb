class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer :target_id
      t.integer :requester_id

      t.timestamps
    end
  end
end
