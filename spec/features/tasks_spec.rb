require "rails_helper"

feature 'Existing user can CRUD a Task' do
  scenario 'signs in, goes to project index page, and clicks through to task showpage' do

    login

    project = create_project

    visit project_tasks_path(project)

    expect(page).to have_content 'Tasks'

  end

  scenario 'can create a new Task and see a success message' do

    project = create_project

    login

    visit project_tasks_path(project)

    click_link 'New Task'

    expect(current_path).to eq new_project_task_path(project)

    fill_in :task_description, with: 'Learn Ruby'
    fill_in :task_due_date, with: '01/01/2011'
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created'
    expect(page).to have_content 'Learn Ruby'
  end

  scenario 'can read an existing Task' do

    project = create_project
    task = create_task(project)

    login

    visit project_tasks_path(project)

    click_link 'Test task for a project'

    expect(current_path).to eq project_task_path(project,task)
    expect(page).to have_content 'Test task for a project'
    expect(page).to have_link 'Edit'
  end

  scenario 'can update an existing task and see a success message' do
    project = create_project
    task = create_task(project)

    login

    visit project_tasks_path(project)

    click_link 'Edit'

    expect(current_path).to eq edit_project_task_path(project,task)

    fill_in :task_description, with: 'Learn Ruby'

    click_button 'Update Task'

    expect(current_path).to eq (project_task_path(project,task))
    expect(page).to have_content 'Task was successfully updated'
  end

  scenario 'delete an existing task' do
    project = create_project
    task = create_task(project)

    login

    visit project_tasks_path(project)

    click_link 'Delete'

    expect(current_path).to eq project_tasks_path(project)
    expect(page).to_not have_content 'Test task for a project'
    expect { task.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'can see validations without a description' do

    project = create_project

    login

    visit project_tasks_path(project)

    click_link 'New Task'

    expect(current_path).to eq new_project_task_path(project)

    click_button 'Create Task'

    expect(page).to have_content '1 error prohibited this form from being saved:
                                  Description can\'t be blank'
  end

end
