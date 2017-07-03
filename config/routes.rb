Rails.application.routes.draw do
  get 'twilio/reply'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get '/messages', to: 'messages#index'
  get '/messages/new', to: 'messages#new'
  post 'messages/send_message' => 'messages#send_message', as: :send_message

  get '/messages/:id', to: 'messages#show'

  root to: "messages#index"
end
