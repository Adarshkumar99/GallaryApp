Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  root 'home#index'
  get 'home/index'
  get 'home/show'
  

  resources :albums do
    collection do
      delete "purge"
    end
  end

  # delete "images/:id/purge", to: "albums#purge", as: "purge_image"

 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
