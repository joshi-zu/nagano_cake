Rails.application.routes.draw do
  namespace :admin do
    resources :items
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end
  devise_for :customers 
  root :to =>"homes#top"
  get "/about" => "homes#about", as: "about"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
