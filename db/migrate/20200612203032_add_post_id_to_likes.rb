class AddPostIdToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :post_id, :integer
    add_column :likes, :comment_id, :integer
  end
end
