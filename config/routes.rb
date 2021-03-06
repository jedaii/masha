Masha::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root 'welcome#index'

  get '/auth/:provider/callback', to: 'omniauth_session#create'
  post '/auth/:provider/callback', to: 'omniauth_session#create'
  # TODO Добавить routes для отработки
  # http://masha.brandymint.ru/auth/failure?message=invalid_credentials&strategy=github

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users, :only => [:new, :create]
  resources :sessions, :only => [:new, :create, :destroy]

  # Личный контроллер пользователя
  resource :profile, :controller => :profile

  resources :projects, :only => [:index, :show, :create, :new]
    resources :memberships
  end
  resources :time_shifts

  namespace :owner do
    root :controller => :users, :action => :index
    resources :projects do
      resources :memberships

      member do
        post :set_role
        delete :remove_role
      end
    end
    resources :users
  end

end
