require 'rails_helper'

describe Task do

  it 'is invalid without a description' do
    task = Task.new(description: nil)
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
  end

  it 'is valid with a description' do
    task = Task.new(description: 'Test')
    task.valid?
    expect(task.description).to include('Test')
  end

end
