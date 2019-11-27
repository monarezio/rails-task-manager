module SignedIn

  class AccountsController < SignedInUserController

    add_breadcrumb 'Account', :account_path

    def show
      @user = current_user
    end

    def update
      @user = current_user

      if @user.update(user_params)
        respond_to do |format|
          format.html { redirect_to edit_account_path, notice: "#{@user.username}'s Account was successfully updated." }
        end
      else
        errors = @user.errors.map { |key, item| "There was a problem with field #{key}: #{item}" }
        respond_to do |format|
          format.html { redirect_to edit_account_path, alert: errors }
        end
      end
    end

    def edit
      add_breadcrumb 'Edit'
      @user = current_user
    end

    def password
      @user = current_user
      if !@user.valid_password?(password_params_with_old_password[:old_password])
        respond_to do |format|
          format.html { redirect_to edit_account_path, alert: "Old password is incorrect." }
        end
      elsif @user.update(password_params)
        bypass_sign_in(@user)
        respond_to do |format|
          format.html { redirect_to edit_account_path, notice: "#{@user.username}'s password was successfully updated." }
        end
      else
        errors = current_user.errors.map { |key, item| "There was a problem with field #{key}: #{item}" }
        respond_to do |format|
          format.html { redirect_to edit_account_path, alert: errors }
        end
      end
    end

    def destroy
      @user = current_user
      if @user.valid_password? only_password_param[:password]
        @user.destroy
        redirect_to root_url, notice: 'Your account has been deleted.'
      else
        respond_to do |format|
          format.html { redirect_to account_path, alert: 'Incorrect password.' }
        end
      end
    end

    private

    def password_params_with_old_password
      params.require(:user)
          .permit(:old_password, :password, :password_confirmation)
    end

    def password_params
      params.require(:user)
          .permit(:password, :password_confirmation)
    end

    def only_password_param
      params.require(:user)
          .permit(:password)
    end

    def user_params
      params.require(:user)
          .permit(:email, :username)
    end
  end

end
