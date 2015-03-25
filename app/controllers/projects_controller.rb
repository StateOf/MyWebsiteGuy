class ProjectsController < PrivateController

  before_action :set_project, only:[:show, :edit, :update, :destroy]
  before_action :ensure_project_member
  before_action :ensure_project_owner

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create(user: current_user, role: 'Owner')
      flash[:message] = "Project was successfully created"
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:message] = "Project was successfully updated"
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:message] = "Project was successfully deleted"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
