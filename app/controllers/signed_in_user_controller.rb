class SignedInUserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record
  around_action :catch_not_found

  protected

  attr_accessor :record

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      flash[:alert] = "#{@record} not found."
      format.html { redirect_to action: 'index' }
    end
  end

  private

  def set_record
    @record = "Record"
  end
end
