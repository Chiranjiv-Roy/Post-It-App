class SocializationsController < ApplicationController
	 before_filter :load_socializable

  def follow
    current_user.follow!(@socializable)
    redirect_to :back
  end

  def unfollow
    current_user.unfollow!(@socializable)
    redirect_to :back
  end

private
  def load_socializable
  	id = params[:id]
    @socializable =User.find(id)
  end
end