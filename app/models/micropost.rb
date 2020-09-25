class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_one_attached :post_image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :post_image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message: "should be less than 5MB" }

  mount_uploader :image, ImageUploader

  def display_post_image
    post_image.variant(resize_to_limit: [500, 500])
  end
end
