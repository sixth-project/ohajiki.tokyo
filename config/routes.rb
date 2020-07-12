Rails.application.routes.draw do
  resources :post_attachments
  resources :categories
devise_for :users, :controllers => { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :like_posts
    end
  end


  root 'posts#home'

  get '/.well-known/acme-challenge/:id' => 'static_pages#certbot'

  get '/about' => 'static_pages#about'

  get '/link' => 'static_pages#link'

  get '/privacy' => 'static_pages#privacy'

  get '/terms' => 'static_pages#terms'

  get '/popular' => 'posts#popular', as: 'popular'

  get '/aoyama' => 'posts#aoyama', as: 'aoyama'

  get '/shibuya' => 'posts#shibuya', as: 'shibuya'

  get '/ginza' => 'posts#ginza', as: 'ginza'

  get '/other' => 'posts#other', as: 'other'

  get '/product' => 'posts#product', as: 'product'

  mount Commontator::Engine => '/commontator' #コメント機能のルート設定

  # 投稿ページのルーティング　
  resources :posts

  post 'like/:post_id' => 'likes#like', as: 'like'
  delete 'unlike/:post_id' => 'likes#unlike', as: 'unlike'

  #エラーのルート5/21
  %w(get put patch post delete).each do |method|
  send(method, '*something', controller: :application, action: :render_404)
  end

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
