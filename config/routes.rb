Rails.application.routes.draw do
    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index'
  get 'products' => 'products#index'
  get 'registrations' => 'registrations#index'
  get 'phones' => 'phones#index'
end
