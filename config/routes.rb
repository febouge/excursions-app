Rails.application.routes.draw do

  #Static pages
  root 'static_pages#home'
  get 'error404' => 'static_pages#error404'
  get 'conditions' => 'static_pages#conditions'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  #Non-statical pages
  resources :excursions do
    resources :registrations
    get 'download', on: :member, constraints: { format: /(html|csv)/ }
  end
  resources :users
end
