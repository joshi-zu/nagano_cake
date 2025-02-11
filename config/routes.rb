Rails.application.routes.draw do
  namespace :admin do
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
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
  resources :customers, only: [:show, :edit, :update] do
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
  end
  resources :addresses, only: [:index, :edit, :update, :destroy, :create ]
  resources :orders, only: [:index, :new, :show, :create] do
    collection do
      get 'confirm'
      get 'thanks'
    end
  end
  resources :cart_items, only: [:index, :create, :update, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end

  get "search" => "searches#search"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
