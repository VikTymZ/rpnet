Rails.application.routes.draw do

  root 'landing#index'

  devise_for :users, skip: [:sessions]
  as :user do
    get '/login', to: 'devise/sessions#new', as: :new_user_session
    post '/login', to: 'devise/sessions#create', as: :user_session
    get '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    get '/dashboard', to: 'dashboard#index'
    get '/dashboard/post/new', to: 'dashboard#new'
    get '/dashboard/post/edit/:id', to: 'dashboard#edit'

    post '/media', to: 'media#fetch'
    post '/media/upload', to: 'media#upload'

    post '/post', to: 'post#get'
    post '/post/create', to: 'post#create'
    post '/post/edit/:id', to: 'post#edit'
    delete '/post/remove', to: 'post#remove'
  end

  # RSS FEED
  get '/feed', to: 'blog#feed'
  get '/blog/feed', to: 'blog#feed'

  get '/blog', to: 'blog#index'
  get '/blog/tags/:tag', to: 'blog#search_tag'
  get '/blog/:slug', to: 'blog#single'
end
