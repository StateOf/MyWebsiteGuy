require "rails_helper"

feature 'Existing user can CRUD a Task' do
  scenario 'visits root_path, signs in, and goes to Task index page' do
    task = Task.new(description: 'Play the banjo', due_date: '01/01/2011')
    task.save!

    sign_in_user

    visit project_tasks_path

    expect(page).to have_content 'Play the banjo'

  end

  scenario 'can create a new Task and see a success message' do

    sign_in_user

    visit project_tasks_path

    click_link 'New Task'

    expect(current_path).to eq new_task_path

    fill_in :task_description, with: 'Learn Ruby'
    fill_in :task_due_date, with: '01/01/2011'
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created'
    expect(page).to have_content 'Learn Ruby'
  end

  scenario 'can read an existing Task' do
    task = Task.new(description: 'Do more homework')
    task.save!

    sign_in_user

    visit project_tasks_path

    click_link 'Do more homework'

    expect(current_path).to eq task_path(task)
    expect(page).to have_content 'Do more homework'
    expect(page).to have_link 'Edit'
  end

  scenario 'can update an existing task and see a success message' do
    task = Task.new(description: 'Figure out the BAM')
    task.save!

    sign_in_user

    visit project_tasks_path

    click_link 'Edit'

    expect(current_path).to eq edit_task_path(task)

    fill_in :task_description, with: 'Learn Ruby'

    click_button 'Update Task'

    expect(current_path).to eq (task_path(task))
    expect(page).to have_content 'Task was successfully updated'
  end

  scenario 'delete an existing task' do
    task = Task.new(description: 'Figure out the BAM', due_date: '01/01/2011')
    task.save!
    sign_in_user

    visit project_tasks_path

    click_link 'Delete'

    expect(current_path).to eq project_tasks_path
    expect(page).to_not have_content 'Figure out the Bam'
    expect { task.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'can see validations without a description' do

    sign_in_user

    visit project_tasks_path

    click_link 'New Task'

    expect(current_path).to eq new_task_path

    click_button 'Create Task'

    expect(page).to have_content '1 error prohibited this form from being saved:
                                  Description can\'t be blank'
  end

end
