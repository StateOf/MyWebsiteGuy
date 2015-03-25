require "rails_helper"

feature 'Existing user can CRUD a User' do

  before :each do

    user = create_user
    login(user)

  end

  scenario 'visits root_path, signs in, and goes to User index page' do

    click_link 'Users'
    expect(current_path).to eq users_path

    expect(page).to have_content 'Steve H'

  end

  scenario 'can create a new User and see success message' do


    click_link 'Users'
    expect(current_path).to eq users_path
    click_link 'New User'

    expect(current_path).to eq new_user_path

    fill_in :user_first_name, with: 'T'
    fill_in :user_last_name, with: 'D'
    fill_in :user_email, with: 'td@broncos.com'
    fill_in :user_password, with: '1234'
    fill_in :user_password_confirmation, with: '1234'

    click_button 'Create User'

    expect(page).to have_content 'User was successfully created'
    expect(page).to have_content 'T D'

  end

  scenario 'can read an existing User' do


    click_link 'Users'

    expect(current_path).to eq users_path

    within '.table' do
      click_link 'Steve H'
    end

    expect(page).to have_content 'Steve H'
    expect(page).to have_content 'First Name'
    expect(page).to have_content 'Last Name'
  end

  scenario 'edit an existing user with success message' do


    click_link 'Users'
    expect(current_path).to eq users_path

    within '.table' do
      click_link 'Steve H'
    end

    click_on 'Edit'

    fill_in "First name", with: 'T'
    fill_in :user_last_name, with: 'D'
    fill_in :user_email, with: 'td@broncos.com'
    fill_in :user_password, with: '1234'
    fill_in :user_password_confirmation, with: '1234'

    click_button 'Update User'

    expect(current_path).to eq users_path
    expect(page).to have_content 'User was successfully updated'
  end

  scenario 'delete an existing user with success message' do

    user1 = create_user(first_name: "Theron", email: "test@gmail.com")

    click_link 'Users'
    expect(current_path).to eq users_path

    within '.table' do
      click_link 'Theron'
    end

    click_on 'Edit'

    click_link 'Delete'

    expect(current_path).to eq users_path

    expect(page).to have_content 'User was successfully deleted'
  end

  scenario 'can see validations without a first name, last name, and email' do

    click_link 'Users'
    expect(current_path).to eq users_path
    click_link 'New User'

    expect(current_path).to eq new_user_path

    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: '123'
    click_button 'Create User'

    expect(page).to have_content '3 errors prohibited this form from being saved:
                                  First name can\'t be blank
                                  Last name can\'t be blank
                                  Email can\'t be blank'
  end

end
