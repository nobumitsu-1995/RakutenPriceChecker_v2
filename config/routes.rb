Rails.application.routes.draw do
  root 'products#index'
  resources :saveitems, only: %i[index show create destroy]
  resources :products, only: %i[index]

  delete '/logout' => 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#create', as: :login
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
