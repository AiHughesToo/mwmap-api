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

    delete 'kill_em_all' => 'locations#kill_em_all'

    post 'deactivated_locations' => 'locations#list_inactive_locations'

    post 'my_locations' => 'locations#find_my_map_locations'

    post 'second_search' => 'locations#search_again'

    get 'send_test_email' => 'locations#send_test_email'

    post 'find_by_state' => 'locations#find_location_by_state'
   
    # #check if this host is correct
    # constraints(:host => 'https://magnawaveportal.com/') do
    #   post 'locations' => 'locations#create'
    # end

    # constraints(:host => '127.0.0.1') do
    #   post 'locations' => 'locations#create'
    # end

    resources :users
    resources :locations
end
