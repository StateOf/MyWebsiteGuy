require "rails_helper"

feature 'Existing user can CRUD a Project' do

  describe 'Existing user' do

    before :each do

      user = create_user
      @project = create_project
      membership = create_membership(user, @project)
      login(user)

    end

    scenario 'existing user logs into the Project index page' do

      expect(current_path).to eq projects_path

    end

    scenario 'can create a new Project and see success message and go to task index page' do

      expect(current_path).to eq projects_path

      within 'nav' do
        click_link 'New Project'
      end

      expect(current_path).to eq new_project_path

      fill_in :project_name, with: 'Learn Ruby'
      click_button 'Create Project'


      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Tasks for Learn Ruby'

    end

    scenario 'can read an existing Project' do

      expect(current_path).to eq projects_path

      within 'table' do
        click_link 'Test Project'
      end

      expect(current_path).to eq project_path(@project)
      expect(page).to have_content 'Test Project'
      expect(page).to have_link 'Edit'
    end

    scenario 'can update an existing project with success message' do

      expect(current_path).to eq projects_path

      within 'table' do
        click_link 'Test Project'
      end

      click_link 'Edit'

      expect(current_path).to eq edit_project_path(@project)

      fill_in :project_name, with: 'Learn Ruby'

      click_button 'Update Project'

      expect(current_path).to eq(project_path(@project))
      expect(page).to have_content 'Project was successfully updated'
    end

    scenario 'delete an existing project with success message' do

      expect(current_path).to eq projects_path

      within 'table' do
        click_link 'Test Project'
      end

      expect(current_path).to eq project_path(@project)
      click_link 'Delete'

      expect(current_path).to eq projects_path
      expect(page).to have_content 'Project was successfully deleted'
      expect { @project.reload }.to raise_error ActiveRecord::RecordNotFound
    end

    scenario 'can see validations without a name' do

      expect(current_path).to eq projects_path

      within 'nav' do
        click_link 'New Project'
      end

      expect(current_path).to eq new_project_path

      click_button 'Create Project'

      expect(page).to have_content '1 error prohibited this form from being saved:
                                    Name can\'t be blank'
    end

  end

  describe "Being a new user" do

    scenario 'new users are redirected to the new projects page after signing up' do

      visit root_path

      within 'nav' do
        click_link 'Sign Up'
      end

      fill_in :user_first_name, with: "Theron"
      fill_in :user_last_name, with: "Hreno"
      fill_in :user_email, with: "test@gmail.com"
      fill_in :user_password, with: "password"
      fill_in :user_password_confirmation, with: "password"
      click_button "Sign Up"

      expect(current_path).to eq new_project_path

    end
  end

end
