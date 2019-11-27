class AddTaskCountToTag < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :tasks_count, :integer
  end
end
