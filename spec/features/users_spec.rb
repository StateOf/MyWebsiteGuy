require "rails_helper"

feature 'Existing user can CRUD a User' do
  scenario 'visits root_path, signs in, and goes to User index page' do
    user = User.new(first_name: 'Steve', last_name: 'H', email:'test@ymail.com', password:'123', password_confirmation: '123')
    user.save!

    sign_in_user

    click_link 'Users'
    expect(current_path).to eq users_path

    expect(page).to have_content 'Steve H'

  end

  scenario 'can make a new User and see success message' do

    sign_in_user

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

  scenario 'edit an existing user' do
    user = User.new(first_name: 'Steve', last_name: 'H', email:'test@ymail.com', password:'123', password_confirmation: '123')
    user.save!
    sign_in_user

    click_link 'Users'
    expect(current_path).to eq users_path
    click_link 'Steve H'

    click_link 'Edit'

    expect(current_path).to eq edit_user_path(user)

    fill_in :user_first_name, with: 'T'
    fill_in :user_last_name, with: 'D'
    fill_in :user_email, with: 'td@broncos.com'
    fill_in :user_password, with: '1234'
    fill_in :user_password_confirmation, with: '1234'

    click_button 'Update User'

    expect(current_path).to eq users_path
    expect(page).to have_content 'User was successfully updated'
  end

  scenario 'delete an existing user' do
    user = User.new(first_name: 'Steve', last_name: 'H', email:'test@ymail.com', password:'123', password_confirmation: '123')
    user.save!
    sign_in_user

    click_link 'Users'
    expect(current_path).to eq users_path

    click_link 'Steve H'

    click_link 'Edit'
    expect(current_path).to eq edit_user_path(user)

    click_link 'Delete'

    expect(current_path).to eq users_path
    expect(page).to have_content 'User was successfully deleted'
    expect { user.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'can see validations without a first name, last name, and email' do

    sign_in_user
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
