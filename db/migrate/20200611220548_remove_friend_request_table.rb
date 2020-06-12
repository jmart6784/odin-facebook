class RemoveFriendRequestTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :friend_requests
  end

  def down
    create_table :friend_requests do |t|
      t.integer :target_id
      t.integer :requester_id

      t.timestamps
    end
  end
end
