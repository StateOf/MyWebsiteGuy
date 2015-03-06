class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = @project.memberships
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end


end
