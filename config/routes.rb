Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root 'polls#index'

  get 'polls', to: 'polls#index'
  get 'admin/:admin_token', to: 'polls#admin'
  get ':token/results', to: 'polls#results'
  post 'vote/:token/', to: 'polls#vote'
  get ':token', to: 'polls#show'
end
