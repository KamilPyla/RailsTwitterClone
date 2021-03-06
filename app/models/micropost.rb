class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  has_many :reported_comments, dependent: :destroy

  scope :reported, ->{ where(reported: true) }
  scope :blocked, ->{ where(blocked: true) }
  scope :correct, ->{ where(blocked: false) }

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, 'should be less than 5 MB')
    end
  end
end
