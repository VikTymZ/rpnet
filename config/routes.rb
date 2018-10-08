Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get '/login', to: 'devise/sessions#new', as: :new_user_session
    post '/login', to: 'devise/sessions#create', as: :user_session
    get '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    get '/dashboard', to: 'dashboard#index'
    get '/dashboard/post/new', to: 'dashboard#new'
    get '/dashboard/post/edit/:id', to: 'dashboard#edit'

    post '/post', to: 'post#get'
    post '/post/create', to: 'post#create'
    post '/post/edit/:id', to: 'post#edit'
    delete '/post/remove', to: 'post#remove'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'landing#index'

  get '/about', to: 'landing#about'
  get '/blog', to: 'blog#index'
  get '/blog/:slug', to: 'blog#single'
end
