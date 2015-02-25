require "rails_helper"

describe "the user using the tasks" do
  it "uses tasks complete" do
    visit root_path

    click_on "Tasks"

    expect(page).to have_content "Tasks"

    click_on "New Task"

    fill_in "Description", with: "hike"
    fill_in "Due date", with: "02/03/2015"

    click_on "Create Task"

    expect(page).to have_content "hike"
    expect(page).to have_content "03/02/2015"

    click_on "Edit"

    fill_in "Description", with: "run"
    fill_in "Due date", with: "02/02/1983"
    check "Complete"

    click_on "Update Task"

    expect(page).to have_content "run"
    expect(page).to have_content "02/02/1983"

    visit tasks_path

    click_on "Delete"

    expect(page).to_not have_content "run"
    expect(page).to_not have_content "02/02/1983"

  end
end
