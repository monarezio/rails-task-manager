class CreateTagAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_associations do |t|

      t.timestamps
    end
  end
end
