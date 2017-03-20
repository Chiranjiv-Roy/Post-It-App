class NotificationsController < ApplicationController

  before_action :logged_in?
  def index
     @notifications = Notification.where(recipient: current_user).unread
  end

end