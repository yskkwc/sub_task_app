class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable

 validates :name, presence: true,
                  length: { maximum: 50 }

      def self.from_omniauth(auth)
            where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            user.name = auth.info.name   # assuming the user model has a name
            user.image = auth.info.image # assuming the user model has an image
            # If you are using confirmable and the provider(s) you use validate emails,
            # uncomment the line below to skip the confirmation emails.
            # user.skip_confirmation!
            end
      end

      def update_without_current_password(params, *options)
            params.delete(:current_password)

            if params[:password].blank? && params[:password_confirmation].blank?
                  params.delete(:password)
                  params.delete(:password_confirmation)
            end

            result = update_attributes(params, *options)
            clean_up_passwords
            result
      end
end
