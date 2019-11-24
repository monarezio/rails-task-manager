module SignedIn

  class AccountsController < SignedInUserController

    def show
      edit # TODO: Yikes
      render 'signed_in/accounts/edit'
    end

    def update
      params.require(:user).permit(:username, :email)

      p params

      current_user.email = params[:email]
      current_user.username = params[:username]
      if current_user.save
        respond_to do |format|
          format.html { redirect_to edit_account_path, notice: 'Account was successfully updated.' }
        end
      else
        errors = current_user.errors.map{|key, item| "There was a problem with field #{key}: #{item}"}
        respond_to do |format|
          format.html { redirect_to edit_account_path, alert: errors }
        end
      end


    end

    def edit
      @user = current_user
      @password_view_model = Password.new
    end
  end

end
