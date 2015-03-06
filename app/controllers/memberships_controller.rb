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
      flash[:notice] = "Member was saved"
      redirect_to project_membership_path(@project, @membership)
    else
      render :new
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "Membership was successfully updated"
      redirect_to project_membership_path
    else
      render :edit
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end


end
