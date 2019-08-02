Rails.application.routes.draw do

  root 'landing#index'

  devise_for :users, skip: [:sessions]
  as :user do
    get '/login', to: 'devise/sessions#new', as: :new_user_session
    post '/login', to: 'devise/sessions#create', as: :user_session
    get '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    get '/dashboard', to: 'dashboard#index'
    get '/dashboard/posts', to: 'dashboard#posts'
    get '/dashboard/posts/new', to: 'dashboard#new'
    get '/dashboard/posts/edit/:id', to: 'dashboard#edit'

    post '/media', to: 'media#fetch'
    post '/media/upload', to: 'media#upload'

    post '/posts', to: 'post#get'
    post '/posts/create', to: 'post#create'
    post '/posts/edit/:id', to: 'post#edit'
    delete '/posts/remove', to: 'post#remove'
  end

  # RSS FEED
  get '/feed', to: 'blog#feed'
  get '/blog/feed', to: 'blog#feed'

  get '/blog', to: 'blog#index'
  get '/blog/tags/:tag', to: 'blog#search_tag'
  get '/blog/:slug', to: 'blog#single'
end
