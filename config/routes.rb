Rails.application.routes.draw do
  get 'sumisne-holosuvannia' => 'sumisne_holosuvannia#init', as: :sumisne_holosuvannia
  get 'sumisne-holosuvannia/api' => 'sumisne_holosuvannia#api', as: :sumisne_holosuvannia_api

  get 'help/faq'

  get 'help/data'

  get 'help/licencing'

  get 'divisions' => 'divisions#index', as: :divisions

  get 'divisions/:date/:id' => 'divisions#show', as: :divisions_show

  get 'people' => 'people#index', as: :people
  get 'people/:mp' => 'people#show', as: :show_people
  get 'people/:mp/divisions' => 'people#divisions', as: :people_divisions
  get 'people/:mp/friends' => 'people#friends', as: :people_friends

  get 'about' => 'about#index', as: :about
  get 'search_mp' => 'home#search_mp', as: :search_mp
  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

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
