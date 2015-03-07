class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:message] = "#{@membership.user.first_name} #{@membership.user.last_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:message] = "#{@membership.user.first_name} #{@membership.user.last_name} was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    if membership.destroy
      flash[:message] = "#{membership.user.first_name} #{membership.user.last_name} was successfully removed"
      redirect_to project_memberships_path
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end


end
