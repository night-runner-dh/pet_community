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


    get 'users/show' => 'users#show', as: :user
    get 'users/infomation/edit' => 'users#edit', as: :infomation_edit
    patch 'users/my_page' => 'users#update', as: :infomation
    get 'users/my_page' => 'users#mypage', as: :my_page
    get 'users/unsubscribe' => 'users#unsubscribe', as: :unsubscribe
    patch 'users/withdraw' => 'users#withdraw', as: :withdraw
  end
  namespace :admin do
    get 'homes/top'
    get 'homes/about'


    resources :users, only: [:show,:edit,:update]
  end


# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end