def sign_in_user
  user = User.new(first_name: 'theron', last_name: 'H', email: 'theron@gmail', password: "1234")
  user.save!
  visit root_path
  click_link 'Sign In'
  fill_in :email, with: user.email
  fill_in :password, with: '1234'
  click_button 'Sign In'
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
