class MicropostsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def new
    @user = current_user
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.order(created_at: :desc)
    @comment = Comment.new
    @comments_page = @comments.paginate(page: params[:page])
  end

  def create
    @user = current_user
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.post_image.attach(params[:micropost][:post_image])
    if @micropost.save
      flash[:notice] = "投稿しました"
      redirect_to users_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'users/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

private
  def micropost_params
    params.require(:micropost).permit(:content, :post_image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
