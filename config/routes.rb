Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index'
<<<<<<< HEAD
  get 'products' => 'products#index'

  get 'card_add' ,to: 'card_add#index'
=======
  get 'registrations' ,to: 'registrations#index'
  get 'phones' ,to: 'phones#index'
  get 'address' ,to: 'address_confirmation#index'
  get 'payment' ,to: 'payment_confirmation#index'
  get 'registration_finish' ,to: 'registration_finish#index'
>>>>>>> JunkiKikuchi/master
end
