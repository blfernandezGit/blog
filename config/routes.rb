Rails.application.routes.draw do
  resources :cashes
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/articles' => 'articles#index'
  get '/articles/new' => 'articles#new', as: 'new_article'
  post '/articles' => 'articles#create', as: 'create_article'
  get 'articles/:id/edit' => 'articles#edit', as: 'edit_article'
  post '/articles/:id' => 'articles#update', as: 'update_article'
  delete '/articles.:id' => 'articles#delete', as: 'delete_article'
  get '/articles/:id' => 'articles#show', as: 'show_article'


  resources :articles do
    resources :comments
  end

  root 'categories#index'

  resources :categories do
      resources :tasks
  end

  get '/tasks/show_tasks_today', to: 'tasks#show_tasks_today', as: 'show_tasks_today'

  # get '*path', to: 'categories#index', via :all
end