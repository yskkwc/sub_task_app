class User < ApplicationRecord
has_many :microposts, dependent: :destroy
has_many :comments
has_many :active_relationships, class_name: "Relationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
has_many :passive_relationships,  class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
has_many :following, through: :active_relationships, source: :followed
has_many :followers, through: :passive_relationships, source: :follower

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

  #メールを必要としないsignup→不要かも?
  #def email_required?
  #  false
  #end

  #def email_changed?
  #  false
  #end

  #def will_save_change_to_email?
  #  false
  #end

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

end
