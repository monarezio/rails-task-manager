class SignedOutUserController < ApplicationController
  before_action :unauthenticate_user

  private
  
  def unauthenticate_user
    if current_user
      redirect_to dashboard_url
    end
  end
end
