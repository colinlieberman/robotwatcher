Rails.application.routes.draw do
  resources :worker_readings
  resources :pool_readings
  resources :workers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
