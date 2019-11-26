class TaskFilter
  include ActiveModel::Model

  attr_accessor :category_id, :tag_ids, :search, :page, :is_done, :group_under_categories
end
