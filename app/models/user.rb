class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', 
                                            foreign_key: 'follower_id',
                                            dependent: :destroy

  has_many :passive_relationships, class_name: 'Relationship',
                                            foreign_key: 'followed_id',
                                            dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token
  before_save { email.downcase! }
  mount_uploader :user_avatar, UserAvatarUploader
  validates :name, presence: true, length: { maximum: 60 }
  validate :user_avatar_size

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    Micropost.where('user_id = ?', id)
  end

  def male?
    self.gender == 'm'
  end

  # Follow a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollow a user.
  def unfollow
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def user_avatar_size
    if user_avatar.size > 5.megabytes
      errors.add(:user_avatar, 'should be less than 5 MB')
    end
  end
end
