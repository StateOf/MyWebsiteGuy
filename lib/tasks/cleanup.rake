namespace :db_tables do
  desc 'Deletes all memberships where their users have already been deleted'
  task cleanup: :environment do
    puts "-"* 100
    membership = Membership.where.not(user_id: User.pluck(:id)).delete_all
    puts "#{membership} Members were deleted because their users were already deleted"
  end

  desc 'Deletes all memberships where their projects have already been deleted'
  task cleanup: :environment do
    puts "-"* 100
    membership = Membership.where.not(project_id: Project.pluck(:id)).delete_all
    puts "#{membership} Members were deleted because their projects were already deleted"
  end

  desc 'Deletes all tasks where their projects have been deleted'
  task cleanup: :environment do
    puts "-"* 100
    task = Task.where.not(project_id: Project.pluck(:id)).delete_all
    puts "#{task} Tasks were deleted because their projects were already deleted"
  end

  desc 'Deletes all comments where their tasks have been deleted'
  task cleanup: :environment do
    puts "-"* 100
    comment = Comment.where.not(task_id: Task.pluck(:id)).delete_all
    puts "#{comment} Comments were deleted because their tasks were already deleted"
  end

  desc 'Sets the user_id of comments to nil if their users have been deleted'
  task cleanup: :environment do
    puts "-"* 100
    comment = Comment.where.not(user_id: User.pluck(:id)).update_all(user_id: nil)
    puts "#{comment} Comment user_id were updated to nil"
  end

  desc ' Deletes any tasks with null project_id'
  task cleanup: :environment do
    puts "-"* 100
    task = Task.where('project_id IS ?', nil).delete_all
    puts "#{task} Tasks with null project_id were deleted"
  end

  desc 'Deletes any comments with a null task_id'
  task cleanup: :environment do
    puts "-"* 100
    comment = Comment.where('task_id IS ?', nil).delete_all
    puts "#{comment} Comments were delete with null task_id"
  end

  desc 'Deletes any memberships with a null project_id or task_id'
  task cleanup: :environment do
    puts "-"* 100
    membership = Membership.where("project_id IS ? OR user_id IS ?",nil,nil ).delete_all
    puts "#{membership} Memberships were deleted with a null project_id or task_id"
    puts "-"* 100
  end

end
