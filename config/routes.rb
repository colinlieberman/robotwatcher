Rails.application.routes.draw do
  resources :pool_readings, only: :index
  resources :workers, only: :show

  get 'df', to: 'pool_readings#df'
  get 'pool_readings/stats', to: 'pool_readings#stats'
  get 'workers/:id/stats', to: 'workers#stats'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
