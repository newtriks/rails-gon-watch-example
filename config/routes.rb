RailsGonWatchExample::Application.routes.draw do
  resources :jobs
  namespace :api do
  	namespace :zencoder do
    	resources :processed
    end
  end
  root :to => 'jobs#index'
end
