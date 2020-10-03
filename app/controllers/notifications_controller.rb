class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page],
                                                              per_page: 10)
  end
end
