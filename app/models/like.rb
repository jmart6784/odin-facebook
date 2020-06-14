class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: {
    scope: :post_id
  }
end
