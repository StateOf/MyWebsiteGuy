require "rails_helper"

describe "the user using the projects" do
  it "uses projects completely" do
    visit root_path

    click_on "Projects"
    
    expect(page).to have_content "Projects"

    click_on "New Project"

    fill_in "Name", with: "test"

    click_on "Create Project"

    expect(page).to have_content "test"

    click_on "Edit"

    fill_in "Name", with: "testing 1,2,3"

    click_on "Update Project"

    expect(page).to have_content "testing 1,2,3"

    click_on "Delete"

    expect(page).to_not have_content "testing 1,2,3"

  end
end
