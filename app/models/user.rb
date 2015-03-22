class User < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :projects, through: :memberships

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def member?(project)
    self.memberships.find_by(project_id: project.id) != nil
  end

  def owner?(project)
    self.memberships.find_by(project_id: project.id).role == "Owner"
  end

end
