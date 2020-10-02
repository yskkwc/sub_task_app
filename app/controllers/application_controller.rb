class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:contact, :policy]

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    users_path(id: current_user.id)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :name])
    # 登録時にusername/nameキーのパラメーターを追加で許可する

    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :username, :name, :image])
    # プロフィール編集時にusername/nameキーのパラメーターを追加で許可する
  end
end
