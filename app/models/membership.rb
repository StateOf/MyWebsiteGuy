class Membership < ActiveRecord::Base

  ROLE = ["Member", "User"]

  belongs_to :user
  belongs_to :project

  validates :user, presence: true
  validates :user, uniqueness: {scope: :user_id, message: " has already been added to this project"}

end
