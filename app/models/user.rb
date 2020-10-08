class User < ApplicationRecord
  has_many :microposts,             dependent:   :destroy
  has_many :comments,               dependent:   :destroy
  has_many :favorite_relationships, dependent:   :destroy
  has_many :likes,                  through:     :favorite_relationships,
                                    source:      :micropost
  has_many :active_relationships,   class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many :passive_relationships,  class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :following,              through:     :active_relationships,
                                    source:      :followed
  has_many :followers,              through:     :passive_relationships,
                                    source:      :follower
  has_many :active_notifications,   class_name:  "Notification",
                                    foreign_key: "visiter_id",
                                    dependent:   :destroy
  has_many :passive_notifications,  class_name:  "Notification",
                                    foreign_key: "visited_id",
                                    dependent:   :destroy

  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable,
    :authentication_keys => [:username]

  validates :name, presence: true,
                    length: { maximum: 50 }
  validates :username, presence: true,
                        length: { maximum: 50 }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.username = auth.info.name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def like(micropost)
    likes << micropost
  end

  def unlike(micropost)
    favorite_relationships.find_by(micropost_id: micropost.id).destroy
  end

  def likes?(micropost)
    likes.include?(micropost)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id=? and visited_id=? and action = ?",
                                current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
