Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :contacts
  resources :invalid_contacts, only: [:index, :destroy]
  resources :import_files do
    collection { post :import }
  end
end
