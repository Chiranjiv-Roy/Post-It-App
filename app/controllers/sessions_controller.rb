class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_username(params[:username])     #This is the line that is causing all the problems
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You've logged in!"
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