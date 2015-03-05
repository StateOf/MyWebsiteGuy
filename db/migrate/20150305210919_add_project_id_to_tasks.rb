class AddProjectIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :prodject_id, :integer
  end
end
