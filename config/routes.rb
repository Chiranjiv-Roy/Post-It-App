PostitTemplate::Application.routes.draw do
  root to: 'pages#show'
  get '/view_posts', to: 'posts#index'
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  resources :posts, on: :member, except: [:destroy] do
    member do
      post 'vote'
    end
    resources :comments, only: [:create] do
      member do
        post 'vote'
      end
    end
  end
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end  
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update] do
    post 'follow',   to: 'socializations#follow', on: :member
    post 'unfollow', to: 'socializations#unfollow', on: :member
  end
end
