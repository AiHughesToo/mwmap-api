Rails.application.routes.draw do
  
  # devise_for :users
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    #login
    post 'user/login' => 'authentication#create'

    #users
    post 'user' => 'users#create'
    post 'request_pass_reset' => 'users#password_reset'

    #locations
    post 'find_locations' => 'locations#find_map_locations'
    
    constraints(:host => 'https://magnawaveportal.com/') do
      post 'locations' => 'locations#create'
    end

    constraints(:host => '127.0.0.1') do
      post 'locations' => 'locations#create'
    end

    resources :users
    resources :locations, except: [:create]
end
