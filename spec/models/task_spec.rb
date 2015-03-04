require 'rails_helper'

describe Task do
  it "is invalid without a description" do
    task = Task.new(description: nil)
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
  end

end
