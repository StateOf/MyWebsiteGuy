require 'rails_helper'

describe Project do
  it "is invalid without a name" do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end

  it 'is valid with a name' do
    project = Project.new(name: 'Test')
    project.valid?
    expect(project.name).to include('Test')
  end

end
