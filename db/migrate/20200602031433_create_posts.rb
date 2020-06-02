class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.integer :comment_id
      t.integer :like_id


      t.timestamps
    end
  end
end
