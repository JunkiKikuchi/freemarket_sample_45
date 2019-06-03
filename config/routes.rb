Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  get 'products' => 'products#index'

  get 'card_add' ,to: 'card_add#index'
end
