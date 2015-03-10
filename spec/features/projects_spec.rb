require "rails_helper"

feature 'Existing user can CRUD a Project' do
  scenario 'visits root_path, signs in, and goes to Project index page' do
    project = Project.new(name: 'Play the banjo')
    project.save!

    login

    click_link 'Projects'
    expect(current_path).to eq projects_path

    expect(page).to have_content 'Play the banjo'

  end

  scenario 'can create a new Project and see success message' do

    login

    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'New Project'

    expect(current_path).to eq new_project_path

    fill_in :project_name, with: 'Learn Ruby'
    click_button 'Create Project'

    expect(page).to have_content 'Project was successfully created'
    expect(page).to have_content 'Learn Ruby'

  end

  scenario 'can read an existing Project' do
    project = Project.new(name: 'Start building apps')
    project.save!

    login
    click_link 'Projects'
    expect(current_path).to eq projects_path

    click_link 'Start building apps'
    expect(current_path).to eq project_path(project)
    expect(page).to have_content 'Start building apps'
    expect(page).to have_link 'Edit'
  end

  scenario 'can update an existing project with success message' do
    project = Project.new(name: 'Figure out the BAM')
    project.save!

    login

    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'Figure out the BAM'

    click_link 'Edit'

    expect(current_path).to eq edit_project_path(project)

    fill_in :project_name, with: 'Learn Ruby'

    click_button 'Update Project'

    expect(current_path).to eq(project_path(project))
    expect(page).to have_content 'Project was successfully updated'
  end

  scenario 'delete an existing project with success message' do
    project = Project.new(name: 'Figure out the BAM')
    project.save!

    login

    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'Figure out the BAM'

    expect(current_path).to eq project_path(project)
    click_link 'Delete'

    expect(current_path).to eq projects_path
    expect(page).to have_content 'Project was successfully deleted'
    expect { project.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'can see validations without a name' do

    login
    click_link 'Projects'
    expect(current_path).to eq projects_path
    click_link 'New Project'

    expect(current_path).to eq new_project_path

    click_button 'Create Project'

    expect(page).to have_content '1 error prohibited this form from being saved:
                                  Name can\'t be blank'
  end

end
