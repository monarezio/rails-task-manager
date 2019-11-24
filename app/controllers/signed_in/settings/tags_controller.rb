module SignedIn
  module Settings

    class TagsController < ApplicationController
      before_action :set_tag, only: [:show, :edit, :update, :destroy]

      # GET /tags
      # GET /tags.json
      def index
        @tags = current_user.tags
      end

      # GET /tags/1
      # GET /tags/1.json
      def show
      end

      # GET /tags/new
      def new
        @tag = Tag.new
      end

      # GET /tags/1/edit
      def edit
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
        @tag = Tag.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def tag_params
        params.require(:tag).permit(:title, :color).merge(:user_id => current_user.id)
      end
    end

  end
end