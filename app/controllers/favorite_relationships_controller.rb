class FavoriteRelationshipsController < ApplicationController
  def create
    @user = current_user
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.create_notification_by(current_user)
    current_user.like(@micropost)
    respond_to do |format|
      format.html { redirect_back(fallback_location: users_path) }
      format.js
    end
  end

  def destroy
    @user = current_user
    @micropost = FavoriteRelationship.find(params[:id]).micropost
    current_user.unlike(@micropost)
    respond_to do |format|
      format.html { redirect_back(fallback_location: users_path) }
      format.js
    end
  end
end
