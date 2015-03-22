class MembershipsController < PrivateController

  before_action :set_project

  before_action :ensure_project_member, only: [:index]
  before_action :ensure_project_owner, only: [:update]
  before_action :membership_and_owner, only: [:update]

  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:message] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:message] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    flash[:message] = "#{membership.user.full_name} was successfully removed"
    redirect_to projects_path
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def membership_and_owner
    @membership = @project.memberships.find(params[:id])
    if @membership.role == 'Owner' && @project.memberships.where(role: 'Owner').count <= 1
      flash[:error] = "Projects must have at least one owner"
      redirect_to project_memberships_path(@project)
    end
  end

end
