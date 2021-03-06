Rails.application.routes.draw do
  resources :comments

  resources :pages do
    collection do
      get 'menus'
      get 'conteudo'
      get 'vote'
      get 'list_institutes'
      post 'list_institutes'
      get 'registration'
      post 'new_user'
      post 'update_user'
      get 'edit_user'
      get 'logo'
      get 'header'
      get 'index_admin'
      get 'login'
      get 'conlayout'
    end
  end

  resources :usuarios
  
  resources :menus do
    collection do
      get 'comments_respond'
    end
  end

  resources :photos
  resources :texts do
    collection do
      get 'save_inline'
    end
  end

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: { registrations: "registrations", confirmations: "confirmations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
    root 'home#index'

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
