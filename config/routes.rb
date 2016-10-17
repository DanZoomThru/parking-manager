Rails.application.routes.draw do
  root :to => "parkings#index"

  resources :parkings
  get 'map', to: 'parkings#map'
end
