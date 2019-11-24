class AddDeadlineAtToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deadlineAt, :datetime
  end
end
