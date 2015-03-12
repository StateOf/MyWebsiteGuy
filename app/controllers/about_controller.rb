class AboutController < ApplicationController

  skip_before_action :ensure_current_user

  def index
    @project = Project.all
    @task = Task.all
    @comment = Comment.all
    @membership = Membership.all
    @user = User.all
  end

end
