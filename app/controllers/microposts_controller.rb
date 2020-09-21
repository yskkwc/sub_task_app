class MicropostsController < ApplicationController
  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def create
    user = current_user
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:notice] = "Micropost created!"
      redirect_to users_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'users/index'
    end
  end

  def destroy
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end
end
