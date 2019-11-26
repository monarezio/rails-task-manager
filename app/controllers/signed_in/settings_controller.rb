module SignedIn
  class SettingsController < SignedInUserController

    add_breadcrumb 'Settings'

    def index
      @user = current_user
    end

  end
end
