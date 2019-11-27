class Task < ApplicationRecord
  private

  attr_writer :days_left, :hours_left

  public

  attr_readonly :days_left, :hours_left

  self.per_page = 30

  belongs_to :user
  belongs_to :category, optional: true, :counter_cache => true

  has_many :tag_associations, dependent: :destroy
  has_many :tags, through: :tag_associations

  validates :title, presence: true, allow_blank: false

  auto_strip_attributes :title, :note, squish: true

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
                .where(:user_id => user_id)
                .paginate(page: task_filter[:page])

    if task_filter[:group_under_categories] === true || task_filter[:group_under_categories] == '1'
      query = query.order('categories.title', :is_done, 'deadline_at is NULL', :deadline_at)
    else
      query = query.order(:is_done, 'deadline_at is NULL', :deadline_at)
    end


    task_filter[:tag_ids] = task_filter[:tag_ids].select { |i| !i.empty? }
    task_filter[:category_id] = task_filter[:category_id].empty? ? nil : task_filter[:category_id].to_i

    if task_filter[:is_done] === true || task_filter[:is_done] == '1'
      query = query.where(:is_done => false)
    end
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

    query
  end
end
