class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  validates :title, presence: true
  validates :image, presence: true, unless: :body?
  validates :title, length: { maximum: 250 }
  validates :body, length: { maximum: 6000 }
  has_one_attached :image, dependent: :destroy

  validate :image_type, unless: ->(x) { x.image.blank? }

  # def thumbnail
  #   return self.image.variant(resize: '300x300!').processed
  # end
  
  private

  def image_type
    if !image.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:image, "needs to be JPG or PNG")
    end
  end
end