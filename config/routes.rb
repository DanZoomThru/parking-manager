Rails.application.routes.draw do
  root :to => "parkings#index"

  resources :parkings
end
