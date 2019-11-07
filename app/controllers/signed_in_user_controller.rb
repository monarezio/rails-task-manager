class SignedInUserController < ApplicationController
  before_action :authenticate_user!
end
