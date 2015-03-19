class AboutController < ApplicationController

  skip_before_action :ensure_current_user

  def index
    @projects = Project.all
    @tasks = Task.all
    @comments = Comment.all
    @memberships = Membership.all
    @users = User.all
  end

end
