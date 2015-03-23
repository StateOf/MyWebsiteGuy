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

  def member_admin?(project)
    self.admin || self.memberships.find_by(project_id: project.id) != nil
  end

  def owner_admin?(project)
    self.admin || self.memberships.find_by(project_id: project.id).role == "Owner" && self.memberships.find_by(project_id: project.id) != nil
  end

  def project_member_of(user)
    user.projects.map(&:users).flatten.include?(self)
  end

end
