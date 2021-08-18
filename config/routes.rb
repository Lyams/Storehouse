Rails.application.routes.draw do
  root to: 'storehouses#index'
  resources :storehouses do
    resources :things
  end
  resources :commodity
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
