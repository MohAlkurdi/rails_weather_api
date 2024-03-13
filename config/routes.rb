Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'weather/:city', to: 'weather#get_weather_data_by_city_name'
  post 'weather/multiple', to: 'weather#get_weather_data_for_multiple_cities'
  get 'weather/statistics/:city', to: 'weather#get_weather_statistics'

  # Defines the root path route ("/")
  # root "posts#index"
end
