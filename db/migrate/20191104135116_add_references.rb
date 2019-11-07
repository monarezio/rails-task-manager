class AddReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :user, foreign_key: true

    add_reference :tasks, :user, foreign_key: true
    add_reference :tasks, :category, foreign_key: true

    add_reference :tags, :user, foreign_key: true

    add_reference :tag_associations, :tag, foreign_key: true
    add_reference :tag_associations, :task, foreign_key: true
  end
end
