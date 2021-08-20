Rails.application.routes.draw do
  root to: 'storehouses#index'
  resources :storehouses do
    resources :deliveries
    resources :things
  end
  resources :commodities
  resources :transfers, only: [:new, :create, :index]
  resources :choose_storehouses,  only: [:new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
