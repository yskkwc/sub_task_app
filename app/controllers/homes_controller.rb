class HomesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to users_path
      #ログイン後はランディングページへ遷移しない
    end
  end

  def policy
  end

  def contact
  end
end
