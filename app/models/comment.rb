class Comment < ApplicationRecord
  belongs_to :post

  validates :body, presence: true
  validates :body, length: { maximum: 6000 }
end
