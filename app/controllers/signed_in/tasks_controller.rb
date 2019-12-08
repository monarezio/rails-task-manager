module SignedIn
  class TasksController < SignedInUserController
    before_action :set_record_name
    before_action :set_task, only: [:edit, :update, :destroy]
    before_action :get_collections_for_selects, only: [:new, :create, :edit, :index]

    add_breadcrumb "Tasks", :tasks_path

    # GET /tasks
    # GET /tasks.json
    def index
      @task_filter = TaskFilter.new(filter_params)
      @is_grouped = @task_filter.group_under_categories
      @is_done = @task_filter.is_done
      @tasks = Task.for_user(current_user.id, filter_params)
      @finished_tasks = []
    end

    # GET /tasks/1
    # GET /tasks/1.json
    def show
      set_task_with_category_and_tags
      add_breadcrumb @task.title
    end

    # GET /tasks/new
    def new
      @task = Task.new
      add_breadcrumb 'New'
    end

    # GET /tasks/1/edit
    def edit
      add_breadcrumb @task.title, task_url(@task)
      add_breadcrumb 'Edit'
    end

    # POST /tasks
    # POST /tasks.json
    def create
      @task = Task.new(task_params)

      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /tasks/1
    # PATCH/PUT /tasks/1.json
    def update
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /tasks/1
    # DELETE /tasks/1.json
    def destroy
      @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      end
    end

    def destroy_multiple
      if task_ids_params.empty?
        respond_to do |format|
          format.html { redirect_to tasks_url, alert: 'No tasks were selected.' }
        end
      else
        Task.destroy_multiple current_user.id, task_ids_params

        respond_to do |format|
          format.html { redirect_to tasks_url, notice: 'Tasks were successfully destroyed.' }
        end
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_task_with_category_and_tags
      @task = current_user.tasks
                  .includes(:category)
                  .includes(:tags)
                  .find(params[:id])
    end

    def get_collections_for_selects
      @categories = current_user.categories
      @tags = current_user.tags
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(
          :title, :note, :is_done, :category_id, {:tag_ids => []}, :deadline_at
      ).merge(:user_id => current_user.id)
    end

    def filter_params
      params.fetch(:task_filter, {
          :search => '',
          :tag_ids => [],
          :category_id => '',
          :page => 1,
          :is_done => true,
          :group_under_categories => true
      }).permit(:search, {:tag_ids => []}, :category_id, :page, :is_done, :group_under_categories)
          .merge(:page => params[:page] ? params[:page] : 1)
    end

    def task_ids_params
      params.fetch('_', {}).reject { |i| params['_'][i] == '0' }
    end

    def set_record_name
      @record = 'Task'
    end
  end
end