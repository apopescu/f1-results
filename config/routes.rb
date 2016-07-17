Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations:  'overrides/registrations'
  }

  # routing for the client side application (to manage all the data),
  # accessible only after LOGIN operation
  namespace :admin do
    post   'drivers'  => 'drivers#create'
    get    'active_drivers'  => 'drivers#show_active_drivers'
    get    'active_drivers/:constructorId'  => 'drivers#show_active_drivers'
    get    'drivers'  => 'drivers#show_all_drivers'
    delete 'drivers/:id' => 'drivers#destroy'
    put    'drivers' => 'drivers#update'

    post   'constructors' => 'constructors#create'
    get    'constructors' => 'constructors#show'
    delete 'constructors/:id' => 'constructors#destroy'
    put    'constructors' => 'constructors#update'

    post   'events' => 'events#create'
    get    'events' => 'events#show'
    delete 'events/:id' => 'events#destroy'
    put    'events' => 'events#update'

    post   'qualis' => 'qualis#create'
    get    'qualis' => 'qualis#show'
    get    'qualiDetails/:id' => 'qualis#getDetails'
    delete 'qualis/:id' => 'qualis#destroy'
    put    'qualis' => 'qualis#update'

    post   'races' => 'races#create'
    get    'races' => 'races#show'
    get    'raceDetails/:id' => 'races#getDetails'
    delete 'races/:id' => 'races#destroy'
    put    'races' => 'races#update'
  end

  # routing for your apps,
  # accessible without any authentication method
  namespace :api2016 do
    get     'drivers' => 'drivers#driver_standing'
    get     'drivers/:driverId' => 'drivers#driver_info'

    get     'constructors' => 'constructors#constructor_standing'
    get     'constructors/:constructorId' => 'constructors#constructor_info'

    get     'races/:round' => 'races#race_results'
    get     'qualis/:round' => 'qualis#quali_results'

    get     'events/:round' => 'events#event_info'
  end

  # in caso di route non esistente fai una redirect alla root
  get '*path' => redirect('/')

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
