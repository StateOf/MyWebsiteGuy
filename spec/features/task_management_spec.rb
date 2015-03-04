require "rails_helper"

feature 'Existing user can create a Task' do
  scenario 'visits root_path, signs in, and goes to Task index page' do
    task = Task.new(description: 'Play the banjo', due_date: '01/01/2011')
    task.save!

    sign_in_user

    click_link 'Tasks'
    expect(current_path).to eq tasks_path

    expect(page).to have_content 'Play the banjo'

  end

  scenario 'can make a new Task' do

    sign_in_user
    click_link 'Tasks'
    expect(current_path).to eq tasks_path
    click_link 'New Task'

    expect(current_path).to eq new_task_path

    fill_in :task_description, with: 'Learn Ruby'
    fill_in :task_due_date, with: '01/01/2011'
    click_button 'Create Task'

    expect(page).to have_content 'Task was successfully created'
    expect(page).to have_content 'Learn Ruby'

  end

  scenario 'edit an existing task' do
    task = Task.new(description: 'Figure out the BAM')
    task.save!
    sign_in_user

    click_link 'Tasks'
    expect(current_path).to eq tasks_path
    click_link 'Figure out the BAM'

    click_link 'Edit'

    expect(current_path).to eq edit_task_path(task)

    fill_in :task_description, with: 'Learn Ruby'

    click_button 'Update Task'

    expect(current_path).to eq (task_path(task))
  end

  scenario 'delete an existing task' do
    task = Task.new(description: 'Figure out the BAM', due_date: '01/01/2011')
    task.save!
    sign_in_user

    click_link 'Tasks'
    expect(current_path).to eq tasks_path
    click_link 'Delete'

    expect(current_path).to eq tasks_path
    expect(page).to_not have_content 'Figure out the Bam'
    expect { task.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
