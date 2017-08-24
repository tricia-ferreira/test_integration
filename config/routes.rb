Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tests#index'
  resources :tests

  # match 'callback', to: 'tests#callback', via: [:post], as: :test_callback
  constraints subdomain: 'codility' do
    post '/:callback' => 'tests#callback', as: :callback
  end
end
