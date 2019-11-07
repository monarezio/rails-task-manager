Rails.application.routes.draw do
  get 'user/index'
  devise_for :users
  root :to => "signed_out/home#index"

  get 'home', to: 'signed_out/home#index'

  get 'dashboard', to: 'signed_in/dashboard#index'
  get 'user', to: 'signed_in/user#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
