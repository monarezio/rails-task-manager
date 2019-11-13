module SignedIn
  class SettingsController < SignedInUserController

    def index
      @user = current_user
    end

  end
end
