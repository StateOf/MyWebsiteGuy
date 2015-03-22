class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_current_user

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def ensure_current_user
    unless current_user
      flash[:error] = 'You must sign in'
      redirect_to sign_in_path
    end
  end

  def ensure_project_member
    if !current_user.member?(@project)
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def ensure_project_owner
    if !current_user.owner?(@project)
      flash[:error] = "You do not have access"
      redirect_to project_path(@project)
    end
  end

  def current_user_or_admin(user)
    user == current_user
  end

  def current_user_404
    if !current_user_or_admin(@user)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end



end
