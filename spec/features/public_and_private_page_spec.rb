require "rails_helper"

feature "Check the private/internal and marketing pages" do

  before :each do

    @user = create_user
    @project = create_project
    membership = create_membership(@user, @project)
    login(@user)

  end

  scenario "as a logged in user gCamp goes to project path" do

    expect(current_path).to eq projects_path

    click_link "gCamp"

    expect(current_path).to eq projects_path

  end

  scenario "there is a drop-down labeled Projects, only contains projects of the logged in user, and a link for New Projects" do

    expect(current_path).to eq projects_path

    click_link "Projects"

    within 'nav' do
      expect(page).to have_content 'Test Project'
      expect(page).to have_content 'New Project'
    end

  end

  scenario "link to Users" do

    expect(current_path).to eq projects_path

    within 'nav' do
      click_link "User"
    end

    expect(current_path).to eq users_path

  end

  scenario "Footer now only has links to Home | About | Terms | FAQ as a logged in user" do

    expect(current_path).to eq projects_path

    within 'footer' do
      expect(page).to have_content 'Home | About | Terms | FAQ'
    end

  end

  scenario "Marketing pages (root, about, faq, and terms) have the same layout" do

    visit root_path

    within 'footer' do
      expect(page).to have_content 'About | Terms | FAQ | Users | Projects'
    end

    within 'nav' do
      expect(page). to have_content "gCamp Sign Out #{@user.full_name}"
    end

    visit about_path

    within 'footer' do
      expect(page).to have_content 'About | Terms | FAQ | Users | Projects'
    end

    within 'nav' do
      expect(page). to have_content "gCamp Sign Out #{@user.full_name}"
    end

    visit faq_path

    within 'footer' do
      expect(page).to have_content 'About | Terms | FAQ | Users | Projects'
    end

    within 'nav' do
      expect(page). to have_content "gCamp Sign Out #{@user.full_name}"
    end

    visit terms_path

    within 'footer' do
      expect(page).to have_content 'About | Terms | FAQ | Users | Projects'
    end

    within 'nav' do
      expect(page). to have_content "gCamp Sign Out #{@user.full_name}"
    end

  end

end
