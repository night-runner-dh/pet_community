Rails.application.routes.draw do

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
    get "search" => "searches#search", as: :search
    
    get 'post/my_posts_index/' => 'posts#my_posts', as: :my_posts
    
    resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    resources :users, only: [:show]
    
  end
  namespace :admin do
    get 'homes/top'
    get 'homes/about'


    resources :users, only: [:show,:edit,:update]
  
    resources :posts, only: [:show, :edit, :update]
  
  end


# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end