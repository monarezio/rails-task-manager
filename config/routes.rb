Rails.application.routes.draw do
  get 'user/index'
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }
  root :to => "signed_out/home#index"

  get 'home', to: 'signed_out/home#index'

  scope module: 'signed_in' do
    resource :account, only: [:show, :update, :edit]
    patch '/account/password', to: 'accounts#password'

    resources :settings, only: [:index]
    resources :tasks

    namespace :settings do
      resources :categories
      resources :tags
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
