Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'borrowers/index'
      post 'borrowers/create'
      get 'borrowers/show/:id', to: 'borrowers#show'

      post 'borrowers/:borrower_id/invoices/create', to: 'invoices#create'
      get 'borrowers/:borrower_id/invoices/show/:id', to: 'invoices#show'
    end
  end
  root 'homepage#index'
  get '/*path', to: 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
