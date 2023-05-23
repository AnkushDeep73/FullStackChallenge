Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'borrowers/index'
      post 'borrowers/create', to: 'borrowers#create'
      get 'borrowers/show/:id', to: 'borrowers#show'

      post 'borrowers/:borrower_id/invoices/create', to: 'invoices#create'
      post 'borrowers/:borrower_id/invoices/:id/approve', to: 'invoices#approve'
      post 'borrowers/:borrower_id/invoices/:id/reject', to: 'invoices#reject'
      post 'borrowers/:borrower_id/invoices/:id/purchase', to: 'invoices#purchase'
      post 'borrowers/:borrower_id/invoices/:id/close', to: 'invoices#close'
      get 'borrowers/:borrower_id/invoices/show/:id', to: 'invoices#show'
    end
  end
  root 'homepage#index'
  get '/*path', to: 'homepage#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
