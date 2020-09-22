class UsersController < ApplicationController

  def index
    if user_signed_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit_password
  end

  def update_password
    if current_user.update_with_password(user_params)
      sign_in(current_user, bypass: true)
      redirect_to users_path, notice: "パスワードを変更しました。"
    else
      flash.now[:alert] = "パスワード変更が失敗しました。再入力してください。"
      render 'edit_password'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
