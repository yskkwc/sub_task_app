class User < ApplicationRecord
has_many :microposts, dependent: :destroy
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

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

end
