class AddDeadlineAtToTask < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :deadlineAt
    add_column :tasks, :deadline_at, :datetime
  end
end
