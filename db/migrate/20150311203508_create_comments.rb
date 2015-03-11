class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :task_id
      t.string :message
      t.timestamps null: false
    end
  end
end
