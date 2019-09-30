Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show]
      post 'postWeibo' => 'posts#create'
      get 'suggest' => 'recommend#suggest'
    end
  end
end
