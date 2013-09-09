Rails4Sandbox::Application.routes.draw do

  get "users/show"
  get "events/index"
  get "events/show"
  # For DoorKeeper
  get "doorkeeper/index"
  get "doorkeeper/index/:page" => "doorkeeper#index"
  get "doorkeeper/events/:event_id/:starts_at/:ends_at" => "doorkeeper#events"
  get "doorkeeper/users/:group_id" => "doorkeeper#users"

  # For Atnd
  get "atnd/index"
  get "atnd/index/:page" => "atnd#index"
  get "atnd/events/:event_id" => "atnd#events"
  get "atnd/users/:owner_id" => "atnd#users"

  # root to: 'top#index'

  # For OmniAuth                                                                                                           s
  get "/auth/:provider/callback" => "sessions#callback"
  get "/auth/failure"            => "sessions#failure"
  get "/logout"                  => "sessions#destroy", as: :logout

  # For Connpass
  namespace :connpass do
    resources :events, :only => [ :index, :show ]
    resources :users,  :only => [ :show ]
  end

  # For Zussar
  namespace :zussar do
    resources :events, :only => [ :index, :show ]
    resources :users,  :only => [ :show ]
  end



  # For Qiita
  get "qiita/tags"
  get "qiita/users"
  get "qiita/index"
  get "qiita/index/:page" => "qiita#index"
  get "qiita/tags/:tag" => "qiita#tags"
  get "qiita/tags/:tag/:page" => "qiita#tags"
  get "qiita/users/:user" => "qiita#users"
  get "qiita/users/:user/:page" => "qiita#users"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'welcome/reference' => 'welcome#reference'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  get 'top/index' => 'top#index'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  # resources :sessions

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
