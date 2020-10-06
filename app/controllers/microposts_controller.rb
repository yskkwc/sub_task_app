class MicropostsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def new
    @user = current_user
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def show
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments.paginate(page: params[:page], per_page: 5)
    @comment = Comment.new
  end

  def create
    @user = current_user
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.post_image.attach(params[:micropost][:post_image])
    if @micropost.save
      flash[:notice] = "投稿しました"
      redirect_to micropost_path(@micropost.id)
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      render 'users/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
  end

  def search
    @microposts = Micropost.search(params[:search]).paginate(page: params[:page], per_page: 10)
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
