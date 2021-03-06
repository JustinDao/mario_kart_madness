MarioKartMadness::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'search#search'

  resources :consoles, :only => [:index, :show]

  resources :games, :only => [:index, :show]

  resources :characters, :only => [:index, :show]

  resources :karts, :only => [:index, :show]

  resources :tracks, :only => [:index, :show]

  resources :items, :only => [:index, :show]

  get '/search/:query', :to => "search#find"

  get '/users/admin', :to => "users#admin", :as => "admin"

  get '/users/all_data', :to => "users#all_data", :as => "all_data"

  post '/users/', :to => "users#create", :as => "create_user"

  get '/signup',  to: 'users#new', :as => "sign_up"
  get '/login',  to: 'sessions#new', :as => "login"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', :as => "logout"

  get '/bulletin/', to: 'messages#index', :as => "bulletin"
  get '/messages/get', to: 'messages#get'
  post '/messages/add', to: 'messages#add'
  delete '/messages/:id', to: 'messages#delete'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
