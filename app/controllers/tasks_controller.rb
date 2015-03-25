class TasksController < PrivateController

  before_action :set_project
  before_action :task_belongs_to_project, only:[:destroy]

  def index
    @tasks = @project.tasks
  end

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:message] = "Task was successfully created"
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      flash[:message] = "Task was successfully updated"
      redirect_to project_task_path
    else
      render :edit
    end
  end

  def destroy
    task = @project.tasks.find(params[:id])
    task.destroy
    redirect_to project_tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

  def task_belongs_to_project
    if !@project.tasks.include?(@task)
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.where(project_id: project.id).find(params[:id])
  end

end
