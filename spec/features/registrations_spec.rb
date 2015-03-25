require 'rails_helper'

feature 'Sign up as a new user' do
  scenario 'can visiy root path and sign up as a new user' do
    visit root_path

    click_link 'Sign Up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'Sign up for gCamp!'
    fill_in :user_first_name, with: 'Steve'
    fill_in :user_last_name, with: 'H'
    fill_in :user_email, with: 'steve@info.com'
    fill_in :user_password, with: '1234'
    fill_in :user_password_confirmation, with: '1234'

    click_button 'Sign Up'

    expect(current_path).to eq new_project_path
    
  end

  scenario 'guest sees validation message when trying to sign up' do

    visit root_path

    click_link 'Sign Up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'Sign up for gCamp!'

    click_button 'Sign Up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'First name can\'t be blank
                                  Last name can\'t be blank
                                  Email can\'t be blank
                                  Password can\'t be blank'
  end
end
