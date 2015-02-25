require "rails_helper"

describe "the user using the users section" do
  it "uses users completely" do
    visit root_path

    click_on "Users"

    expect(page).to have_content "Users"

    click_on "New User"

    fill_in "First name", with: "Steve"
    fill_in "Last name", with: "Hirschhorn"
    fill_in "Email", with: "test@test.com"

    click_on "Create User"

    expect(page).to have_content "Steve Hirschhorn"
    expect(page).to have_content "test@test.com"

    click_link "edit"

    fill_in "First name", with: "Steve"
    fill_in "Last name", with: "Hirschhorn"
    fill_in "Email", with: "test1@test.com"

    click_on "Update User"

    expect(page).to have_content "Steve Hirschhorn"
    expect(page).to have_content "test1@test.com"

    click_on "edit"
    click_on "Delete user"

    expect(page).to_not have_content "Steve Hirschhorn"
    expect(page).to_not have_content "test1@test.com"

  end
end
