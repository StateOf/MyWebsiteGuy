require "rails_helper"

feature 'Existing user can create a Project' do
  scenario 'visits root_path, signs in, and goes to Project index page' do
    project = Project.new(name: 'Play the banjo')
    project.save!

    sign_in_user

    click_link 'Projects'
    expect(current_path).to eq projects_path

    expect(page).to have_content 'Play the banjo'

  end

  scenario 'can make a new Project' do

    sign_in_user
    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'New Project'

    expect(current_path).to eq new_project_path

    fill_in :project_name, with: 'Learn Ruby'
    click_button 'Create Project'

    expect(page).to have_content 'Project was successfully created'
    expect(page).to have_content 'Learn Ruby'

  end

  scenario 'edit an existing project' do
    project = Project.new(name: 'Figure out the BAM')
    project.save!
    sign_in_user

    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'Figure out the BAM'

    click_link 'Edit'

    expect(current_path).to eq edit_project_path(project)

    fill_in :project_name, with: 'Learn Ruby'

    click_button 'Update Project'

    expect(current_path).to eq(project_path(project))
  end

  scenario 'delete an existing project' do
    project = Project.new(name: 'Figure out the BAM')
    project.save!
    sign_in_user

    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'Figure out the BAM'

    expect(current_path).to eq project_path(project)
    click_link 'Delete'

    expect(current_path).to eq projects_path
    expect(page).to have_content 'Project was successfully deleted'
    expect { project.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end
