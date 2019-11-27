class AddTaskCountToTag2 < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :tag_associations_count, :integer
  end
end
