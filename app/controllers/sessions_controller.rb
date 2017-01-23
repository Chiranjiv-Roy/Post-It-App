class SessionsController < ApplicationController

  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],:uid => auth['uid']).first || User.from_omniauth(env["omniauth.auth"])      
    if user #& user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You've logged in via facebook!"
      redirect_to root_path
    else
      flash[:notice] = "There's something wrong with your username and password."
      redirect_to login_path
    end
  end

  def destroy
      session[:user_id] = nil
      flash[:notice] = "You've logged out."
      redirect_to root_path
  end

end