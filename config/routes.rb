Rails.application.routes.draw do

  namespace :public do
    get 'groups/new'
    get 'groups/index'
    get 'groups/show'
    get 'groups/edit'
  end
  # 会員用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

root to: 'public/homes#top'


  namespace :public do

    get 'homes/top'
    get 'homes/about'
    get 'users' => 'users#index', as: :users 
    get 'users/infomation/edit' => 'users#edit', as: :information_edit
    patch 'users/my_page' => 'users#update', as: :information
    get 'users/my_page' => 'users#mypage', as: :my_page
    get 'users/unsubscribe' => 'users#unsubscribe', as: :unsubscribe
    patch 'users/withdraw' => 'users#withdraw', as: :withdraw
    get 'search' => 'searches#search', as: :search
    
    get 'posts/image_index' => 'posts#image_index', as: :image_index
    get 'post/my_posts/' => 'posts#my_posts', as: :my_posts
    get "groups/:id/permits" => "groups#permits", as: :permits
    get '/tags/:name', to: 'tags#index', as: :tag
    
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resource :post_comments, only: [:create, :destroy]
    end
  
  
    resources :users, only: [:show] do
      resources :favorites, only: [:index]
      resource :relationships, only: [:create, :destroy]
  	  get "followings" => "relationships#followings", as: :followings
  	  get "followers" => "relationships#followers", as: :followers
    end
    
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      resource :permits, only: [:create, :destroy]
      resources :group_comments, only: [:create, :destroy]
    end
    
    
  end
  namespace :admin do
    get 'homes/top' => 'homes#top', as: :homes_top
    get 'homes/about'
    get 'posts/my_posts' => 'posts#my_posts', as: :my_posts
    resources :users, only: [:show,:edit,:update]
  
    resources :posts, only: [:show,:update, :index, :destroy]
    resources :groups, only: [:index, :destroy, :show] do
      resource :group_comments, only: [:destroy]
    end
    
  end


# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end