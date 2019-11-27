class AddTaskCountToTagAssociations < ActiveRecord::Migration[6.0]
  def change
    remove_column :tags, :tasks_count
    add_column :tag_associations, :tag_associations_count, :integer
  end
end
