Rails.application.routes.draw do
  get 'twilio/reply'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resource :messages do
  end

  get '/texts/new', to: 'texts#new'
  post 'texts/send_text' => 'texts#send_text', as: :send_text
  root to: "messages#index"

end
