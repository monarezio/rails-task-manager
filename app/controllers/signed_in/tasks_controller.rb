module SignedIn
  class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    # GET /tasks
    # GET /tasks.json
    def index
      @categories = current_user.categories.to_a
      empty_category = Category.new({:id => -1, :title => 'Uncategorized'})
      @categories.unshift empty_category

      @tags = current_user.tags

      p 'PARAMS: '
      p params

      @tasks = Task.for_user(current_user.id, filter_params)
    end

    # GET /tasks/1
    # GET /tasks/1.json
    def show
    end

    # GET /tasks/new
    def new
      @categories = current_user.categories
      @tags = current_user.tags
      @task = Task.new
    end

    # GET /tasks/1/edit
    def edit
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

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
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
          :page => 1
      }).permit(:search, {:tag_ids => []}, :category_id, :page)
      .merge(:page => params[:page] ? params[:page] : 1)
    end
  end
end