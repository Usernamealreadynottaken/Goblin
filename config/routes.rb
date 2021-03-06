Goblin::Application.routes.draw do
  root to: "sessions#new"
  
  match '/profile', to: 'user#show', via: 'get', as: 'profile'
  match '/friends/:id/flag', to: 'user#get_update_flag', via: 'post', as: 'get_update_flag'
  match '/friends/:id/accept_friendship/:friend_id', to: 'user#accept_friendship', via: 'post', as: 'accept_friendship'
  match '/friends/:id/create_friendship/:friend_name', to: 'user#create_friendship', via: 'post', as: 'create_friendship'
  match '/friends/:id/remove_friendship/:friend_id', to: 'user#remove_friendship', via: 'post', as: 'remove_friendship'
  
  match '/game/:id', to: 'games#show', via: 'get', as: 'game'
  match '/game/update_category/:category_id/in_item/:item_id', 
    to: 'games#update_category_in_item', via: 'post', as: 'update_category_in_item'
  match 'game/update_player/:user_id/in_item/:item_id',
    to: 'games#update_player_in_item', via: 'post', as: 'update_player_in_item'
  
  match '/signin', to: 'sessions#create', via: 'post', as: 'sign_in'
  match '/signin', to: 'sessions#new', via: 'get', as: 'sign_in_get'
  match '/logout', to: 'sessions#destroy', via: 'post', as: 'sign_out'
  
  match '/item/add', to: 'items#add', via: 'post', as: 'item_add'
  match '/item/update', to: 'items#update', via: 'post', as: 'item_update'
  match '/item/delete', to: 'items#delete', via: 'post', as: 'item_delete'
  
  match '/gamecat/add', to: 'game_categories#add', via: 'post', as: 'game_category_add'
  match '/gamecat/update', to: 'game_categories#update', via: 'post', as: 'game_category_update'
  match '/gamecat/delete', to: 'game_categories#delete', via: 'post', as: 'game_category_delete'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
