module SignedIn
  module Settings

    class TagsController < SignedInUserController
      before_action :set_record_name
      before_action :set_tag, only: [:edit, :update, :destroy]
      before_action :set_tag_with_tasks, only: [:show]

      add_breadcrumb 'Settings', :settings_path
      add_breadcrumb 'Tags', :settings_tags_path

      # GET /tags
      # GET /tags.json
      def index
        @tags = current_user.tags
      end

      # GET /tags/1
      # GET /tags/1.json
      def show
        add_breadcrumb @tag.title
      end

      # GET /tags/new
      def new
        add_breadcrumb 'New'
        @tag = Tag.new
      end

      # GET /tags/1/edit
      def edit
        add_breadcrumb @tag.title, settings_tag_path(@tag)
        add_breadcrumb 'Edit'
      end

      # POST /tags
      # POST /tags.json
      def create
        @tag = Tag.new(tag_params)

        respond_to do |format|
          if @tag.save
            format.html { redirect_to [:settings, @tag], notice: 'Tag was successfully created.' }
          else
            format.html { render :new }
          end
        end
      end

      # PATCH/PUT /tags/1
      # PATCH/PUT /tags/1.json
      def update
        respond_to do |format|
          if @tag.update(tag_params)
            format.html { redirect_to [:settings, @tag], notice: 'Tag was successfully updated.' }
          else
            format.html { render :edit }
          end
        end
      end

      # DELETE /tags/1
      # DELETE /tags/1.json
      def destroy
        @tag.destroy
        respond_to do |format|
          format.html { redirect_to settings_tags_url, notice: 'Tag was successfully destroyed.' }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_tag
        @tag = current_user.tags.find(params[:id])
      end

      def set_tag_with_tasks
        @tag = current_user.tags
                   .includes(:tasks)
                   .order(:is_done, 'tasks.deadline_at is NULL', :deadline_at)
                   .find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def tag_params
        params.require(:tag).permit(:title, :color).merge(:user_id => current_user.id)
      end

      def set_record_name
        @record = 'Tag'
      end
    end

  end
end