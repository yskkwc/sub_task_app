class MicropostsController < ApplicationController
  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def create
    user = current_user
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "Micropost created!"
      redirect_to users_path
    else
      flash.now[:alert] = "投稿が出来ませんでした。"
      render 'user/user.id'
    end
  end

  def destroy
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
