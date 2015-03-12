require 'rails_helper'

describe User do
  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without matching password and password confirmation" do
    user = User.new(password: '1234', password_confirmation: '123')
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "replaces use_id in comments table with nil when destroy is called on a user" do
    user = User.create!(first_name: 'steve', last_name: 'h', email: 'test@gmail.com', password: '123', password_confirmation: '123')
    comment = Comment.create!(user_id: user.id, task_id: 1, message:'test')
    user.destroy
    expect(comment.reload.user_id).to eq(nil)
    expect(comment.reload.message).to eq(comment.message)
    expect(comment.reload.task_id).to eq(comment.task_id)
  end

end
