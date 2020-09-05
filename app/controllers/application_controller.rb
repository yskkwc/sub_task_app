class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    user_path(id: current_user.id)
  end
end
