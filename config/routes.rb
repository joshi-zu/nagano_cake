Rails.application.routes.draw do
  namespace :admin do
    resources :items
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
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
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
