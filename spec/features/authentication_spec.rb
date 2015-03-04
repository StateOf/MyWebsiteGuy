require 'rails_helper'

feature 'Sign in as an existing user' do
  scenario 'can log in to see tasks, projects, and users' do
    user = User.new(first_name: 'T', last_name: 'H', email: 'theron@gmail', password: "1234")
    user.save!

    visit root_path
    click_link 'Sign In'

    expect(current_path).to eq '/sign-in'
    expect(page).to have_content 'Sign into gCamp'

    fill_in :email, with: user.email
    fill_in :password, with: '1234'
    click_button 'Sign In'

    expect(current_path).to eq root_path
    expect(page).to have_content 'You have successfully signed in'
    expect(page).to have_content 'Your life, organized'

    user.destroy!

  end
end
