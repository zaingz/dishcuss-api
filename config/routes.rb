Rails.application.routes.draw do
  resources :photos, except: [:new, :edit]
  
  
  #resources :posts, except: [:new, :edit]
  resources :categories, except: [:new, :edit]
  #mount Knock::Engine => "/knock"
  
  
  #resources :identities, except: [:new, :edit]
  #resources :users, except: [:new, :edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



  #final Routes
  scope "user" do
    post 'signup' => 'users#create'
    delete 'signout' => 'users#signout'
    post 'restaurant/signup' => 'users#restaurant_user_create'
    post 'signin' => 'users#signin'
    get 'email/verify/:token' => 'users#verify_email'
    get 'follow/:id' => 'users#follow'
    get 'unfollow/:id' => 'users#unfollow'
    get 'followers' => 'users#followers'
    post 'reviews' => 'reviews#create_user_review'
    get 'social/:id' => 'users#social'
    post 'message/:id' => 'users#message'
    post ':type/:id' => 'users#report'
    resources :posts , except: [:new, :edit , :show]
    get 'like/:typee/:id' => 'users#likers'
    get 'dislike/:typee/:id' => 'users#dislike' 
    scope 'posts' do
      get 'likes/:id' => 'posts#likeable'
      post 'comment/new' => 'posts#comment'
      get 'comments/:id' => 'posts#showcomment'
      resources :checkins, except: [:new, :edit]
    end
  end
  resources :restaurants, except: [:new, :edit]
  scope "restaurants" do
    get 'social/:id' => 'restaurants#social'
    get 'follow/:id' => 'restaurants#follow'
    get 'unfollow/:id' => 'restaurants#unfollow'
    post 'reviews' => 'reviews#create_restaurant_review'
    resources :menus, except: [:new, :edit]
    scope 'menus' do
      resources :food_items, except: [:new, :edit]
    end
  end
  resources :reviews, except: [:new, :edit]
  post 'reviews/comment' => 'reviews#comment'
  get 'reviews/comment/:id' => 'reviews#showcomment'
  get 'restaurants/approve/:id' => 'admin#approve_restaurant'
  get 'restaurants/feature/:id' => 'admin#feature_restaurant'

  post 'pundit' => 'admin#create_pundit'
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
