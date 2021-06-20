Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  get 'users/edit'
  get 'books/show'
  get 'books/index'
  get 'books/edit'
  devise_for :users
  root 'homes#top'
  get 'about' => 'homes#about' 
 
  resources :books, only:[:show,:edit,:index,:update,:destroy,:create]
  resources :users, only:[:show,:index,:edit,:update]
end
