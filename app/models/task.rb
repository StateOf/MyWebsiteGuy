class Task < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :project

  validates :description, presence: true

end
