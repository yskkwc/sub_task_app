class Micropost < ApplicationRecord
  belongs_to :user

  has_many :comments,               dependent: :destroy
  has_many :favorite_relationships, dependent: :destroy
  has_many :liked_by,               through:   :favorite_relationships,
                                    source:    :user
  has_many :notifications,          dependent: :destroy

  has_one_attached :post_image
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :post_image,
    content_type: { in: %w[image/jpeg image/gif image/png],
      message: "must be a valid image format" },
    size:         { less_than: 5.megabytes,
      message: "should be less than 5MB" },presence: true
    #投稿には画像を必須とする

  mount_uploader :image, ImageUploader

  def display_post_image
    post_image.variant(resize_to_limit: [500, 500])
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      visited_id:   user_id,
      action:       "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def self.search(search)
    if search
      Micropost.where(['content LIKE ?', "%#{search}%"])
    else
      Micropost.all
    end
  end
end
