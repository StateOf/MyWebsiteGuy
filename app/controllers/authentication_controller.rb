class AuthenticationController < ApplicationController

  skip_before_action :ensure_current_user

  def new
    user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully signed in"
      redirect_to root_path
    else
      flash[:warning] = "Email / Password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end

end
