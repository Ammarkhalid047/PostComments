Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'
  
  get 'home/index'
  root 'home#index'
  resources :posts do
    resources :comments 
  end
  post '/admin/posts/:id/change_status', to: 'admin/posts#change_status', as: :admin_posts_change_status
  post '/admin/users/:id/change_user', to: 'admin/users#change_user', as: :admin_users_change_user
  get '/posts/temp', to: 'posts#temp'
  get '/comments/delete', to: 'comments#destroy'
  get '/posts/:post_id/comments', to: 'comments#create_comment'
  get '/admin/pending', to:'admin#pending_approvals'
  resources :admin do
    member do
      get :all_users  
      get :approve
      get :reject
      get :change_status
    end
  end
  devise_for :users, :controllers => {:registrations => "users/registrations", :sessions => "users/sessions"}
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
