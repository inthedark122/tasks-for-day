Rails.application.routes.draw do
  mount_ember_app :frontend, to: '/'

  devise_for :users, only: []
  as :users do
    authenticated :users do
      root 'pages#index', as: :authenticated_root
    end

    unauthenticated do
      root 'pages#index', as: :unauthenticated_root
    end
  end

  namespace :'api/v1', path: 'api/v1', as: :api_v1 do

    resources :tasks do
      member do
        patch :start
        patch :finish
      end
    end

    # User config
    as :user do
      # registration
      post 'sign_up' => 'users/registrations#create', :as => :user_registration
      delete 'destroy' => 'users/registrations#destroy', :as => :destroy_user_registration

      # session
      post 'signin' => 'users/sessions#create', :as => :user_session
      delete 'signout' => 'users/sessions#destroy', :as => :destroy_user_session
    end

  end
end
