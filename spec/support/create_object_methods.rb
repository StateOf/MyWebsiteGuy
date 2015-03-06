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

def create_task (project, options = {})
  Task.create!({
   description: 'Test task for a project',
   :project_id => project.id,
   complete: true,
 }.merge(options))
end
