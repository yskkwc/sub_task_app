class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = "コメントしました"
      redirect_to micropost_path(@micropost)
    else
      flash[:alert] = "コメントに失敗しました"
      redirect_to micropost_path(@micropost)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, micropost_id: params[:micropost_id])
  end
end
