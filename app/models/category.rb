class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  attr_readonly :task_count

  auto_strip_attributes :title, squish: true

  def self.for_user_with_task_count(user_id)
    categories = Category.all.where(user_id: user_id).includes(:tasks)
    @task_count = categories.tasks.count
    categories
  end
end
