Rails.application.routes.draw do

  namespace :admin do
    resources :items
  end

  root :to =>"homes#top"
  get "/about" => "homes#about", as: "about"

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
