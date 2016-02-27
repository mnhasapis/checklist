Rails.application.routes.draw do
  devise_for :users
  resources :goals do
    member do
      patch :complete
  end
end
  root 'goals#index'
  
end
