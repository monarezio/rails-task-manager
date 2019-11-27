class AddTaskCountToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :tasks_count, :integer
  end
end
