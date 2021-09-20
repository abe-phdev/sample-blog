Rails.application.routes.draw do
  root to: "blogs#index"

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :blogs do
    resources :comments, module: :blogs
  end

  resources :tweets do
    resources :comments, module: :tweets
  end
end
