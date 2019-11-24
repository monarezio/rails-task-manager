class Task < ApplicationRecord
  private

  attr_writer :days_left, :hours_left

  public

  attr_readonly :days_left, :hours_left

  self.per_page = 5 #TODO: Change later

  belongs_to :user
  belongs_to :category

  has_many :tag_associations
  has_many :tags, through: :tag_associations

  def days_left
    if @days_left == nil
      @days_left = (deadline_at.to_date - Date.today).to_i
    end

    @days_left
  end

  def hours_left
    if @hours_left == nil
      @hours_left = ((deadline_at.to_datetime - DateTime.now) * 24).to_i
    end

    @hours_left
  end

  def self.for_user(user_id, task_filter = nil)
    query = Task.all
                .includes(:category)
                .order('categories.title', :deadline_at)
                .where(:user_id => user_id)
                .paginate(page: task_filter[:page])

    if task_filter
      task_filter[:tag_ids] = task_filter[:tag_ids].select { |i| !i.empty? }
      task_filter[:category_id] = task_filter[:category_id].empty? ? nil : task_filter[:category_id].to_i

      if task_filter[:category_id] == -1
        query = query.where(:category_id => nil)
      elsif task_filter[:category_id]
        query = query.where(:category_id => task_filter[:category_id])
      end
      if task_filter[:tag_ids] != nil && !task_filter[:tag_ids].empty?
        query = query.includes(:tag_associations)
                    .where('tag_associations.tag_id' => task_filter[:tag_ids])
      end
      if task_filter[:search]
        query = query.where('tasks.title LIKE ? OR tasks.note LIKE ?', "%#{task_filter[:search]}%", "%#{task_filter[:search]}%")
      end
    end

    query
  end
end
