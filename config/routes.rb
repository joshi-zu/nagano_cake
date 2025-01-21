Rails.application.routes.draw do

  namespace :admin do
    resources :items
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
  }

  devise_for :customers, skip: [:passwords], controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }
  
  root :to =>"homes#top"
  get "/about" => "homes#about", as: "about"

  resources :items, only: [:index, :show]
  resources :customers, only: [:show, :edit, :update, :withdraw]
  resources :addresses, only: [:index, :edit, :update, :destroy, :create ]
  resources :orders, only: [:confirm, :index, :new, :show, :thanks]
  resources :cart_items, only: [:index, :show, :create, :edit, :update, :destroy]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
