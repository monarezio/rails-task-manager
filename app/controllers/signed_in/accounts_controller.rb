module SignedIn

  class AccountsController < SignedInUserController

    def show
    end

    def update
      params.require(:user).permit(:username, :email)

      p params

      current_user.email = params[:email]
      current_user.username = params[:username]
      current_user.save

      redirect_to edit_account_path
    end

    def edit
      @user = current_user
      @password_view_model = Password.new
    end
  end

end
