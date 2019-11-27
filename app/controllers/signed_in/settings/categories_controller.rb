module SignedIn
  module Settings

    class CategoriesController < SignedInUserController
      before_action :set_record_name
      before_action :set_category, only: [:edit, :update, :destroy]
      before_action :set_category_with_tasks, only: [:show]

      add_breadcrumb 'Settings', :settings_path
      add_breadcrumb 'Categories', :settings_categories_path

      # GET /categories
      # GET /categories.json
      def index
        @categories = current_user.categories.all
      end

      # GET /categories/1
      # GET /categories/1.json
      def show
        add_breadcrumb @category.title
      end

      # GET /categories/new
      def new
        add_breadcrumb 'New'
        @category = Category.new
      end

      # GET /categories/1/edit
      def edit
        add_breadcrumb @category.title, settings_category_path(@category)
        add_breadcrumb 'Edit'
      end

      # POST /categories
      # POST /categories.json
      def create
        @category = Category.new(category_params)

        respond_to do |format|
          if @category.save
            format.html { redirect_to settings_category_path(@category.id), notice: 'Category was successfully created.' }
          else
            format.html { render :new }
          end
        end
      end

      # PATCH/PUT /categories/1
      # PATCH/PUT /categories/1.json
      def update
        respond_to do |format|
          if @category.update(category_params)
            format.html { redirect_to settings_category_path(@category.id), notice: 'Category was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
      end

      # DELETE /categories/1
      # DELETE /categories/1.json
      def destroy
        @category.destroy
        respond_to do |format|
          format.html { redirect_to settings_categories_path, notice: 'Category was successfully destroyed.' }
        end
      end

      private

      def set_category_with_tasks
        @category = current_user.categories
                        .includes(:tasks)
                        .order(:is_done, 'tasks.deadline_at is NULL', :deadline_at)
                        .find(params[:id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = current_user.categories.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def category_params
        params.require(:category).permit(:title, :color).merge(:user_id => current_user.id)
      end

      def set_record_name
        @record = 'Catgeory'
      end
    end

  end
end