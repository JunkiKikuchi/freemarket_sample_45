Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index'
  get products: :"products#index"
  get registrations: :'registrations#index'
  get phones: :'phones#index'
  get address: :'address_confirmation#index'
  get payment: :'payment_confirmation#index'
  get registration_finish: :'registration_finish#index'
end
