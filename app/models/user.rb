class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name 
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  has_one_attached :avatar, dependent: :destroy
  validate :avatar_type
      
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  validates :first_name, :last_name, presence: true, length: { minimum: 3 }
  validates :bio, length: { maximum: 1300 }

  after_create :send_welcome_email

  def add_friend(another_user)
    friends << another_user
  end

  def is_friend?(another_user)
    friends.include?(another_user)
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now!
  end

  def avatar_type
    if !avatar.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:avatar, "needs to be JPG or PNG")
    end
  end
end