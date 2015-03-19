  def create_user(options= {})
  User.create!({
    first_name: 'Steve',
    last_name: 'H',
    email: 'testingtesting@gmail.com',
    password: 'password',
  }.merge(options))
end

def create_project(options= {})
  Project.create!({
    name: 'Test Project',
  }.merge(options))
end

def create_task(project, options = {})
  Task.create!({
   description: 'Test task for a project',
   :project_id => project.id,
   due_date: "2015-01-01",
   complete: true,
  }.merge(options))
end

def create_membership(user, project, options = {})
  Membership.create!({
    role: "Owner",
    :user_id => user.id,
    :project_id => project.id,
  }.merge(options))
end

def create_comment(user, task, options = {})
  Comment.create!({
    message: "This is a test comment!",
    :user_id => user.id,
    :task_id => task.id,
  }.merge(options))
end
