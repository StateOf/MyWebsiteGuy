# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


100.times do
  role = ["Member", "User"]
  Membership.create!(role: role.shuffle.first, project_id: rand(100)+1, user_id: rand(100)+1)
end

100.times do
  role = ["Member", "User"]
  Membership.create!(role: role.shuffle.first, project_id: rand(100)+1)
end

100.times do
  role = ["Member", "User"]
  Membership.create!(role: role.shuffle.first, user_id: rand(100)+1)
end

100.times do
  Task.create!(description: "test", project_id: 9999)
end

100.times do
  Task.create!(description: "testing1", project_id: nil)
end

100.times do
  Comment.create!(message: "DYLANS MOM", task_id: 999999)
end

100.times do
  Comment.create!(message: "KILL CODE", task_id: nil)
end
