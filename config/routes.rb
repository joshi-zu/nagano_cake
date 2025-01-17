Rails.application.routes.draw do
  namespace :admin do
    resources :items
  end
  devise_for :customers
  root :to =>"homes#top"
  get "/about" => "homes#about", as: "about"

  resources :items, only: [:index, :show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
