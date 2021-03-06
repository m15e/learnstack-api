Rails.application.routes.draw do  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :stacks, only: [:index, :show, :create, :destroy]
      resources :favorites, only: [:index, :create, :destroy]
      resources :links, only: [:create, :destroy]
      resources :users, only: [:index, :create, :destroy]      
      post 'authenticate', to: 'authentication#create'
    end 
  end
end
 