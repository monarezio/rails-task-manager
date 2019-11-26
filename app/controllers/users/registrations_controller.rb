# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super do |user|

      p 'I AM HERE  '

      category_personal = user.categories.create({title:  "Osobní", color: '#2ecc71'})
      category_school = user.categories.create({title:  "Škola", color: '#3498db'})
      user.categories.create({title:  "Práce", color: '#e74c3c'})

      tag_ucl = user.tags.create({title: 'UCL', color: '#e67e22'})
      user.tags.create({title: 'JSE', color: '#f1c40f'})
      tag_web = user.tags.create({title: 'WEB', color: '#16a085'})
      user.tags.create({title: '3DT', color: '#9b59b6'})
      user.tags.create({title: 'PR1', color: '#34495e'})
      user.tags.create({title: 'PES', color: '#95a5a6'})
      tag_buy = user.tags.create({title: 'Nákupy', color: '#2ecc71'})
      user.tags.create({title: 'Wishlist', color: '#3498db'})

      user.tasks.create(
          {:title => 'Toto je jednoduchý úkol 👎', :is_done => false}
      )

      user.tasks.create(
          {:title => 'Toto je už dokončený úkol 👍', :is_done => true}
      )

      user.tasks.create(
          {:title => 'Nakoupit na večeři 🌭', :is_done => false, :category => category_personal, :tags => [tag_buy]}
      )

      user.tasks.create(
          {:title => 'Udělat semestrální práci z předmětu WEB 🕸', :is_done => false, :category => category_school, :tags => [tag_ucl, tag_web]}
      )

      user.save!
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
