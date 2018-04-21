Rails.application.routes.draw do

  devise_for :users, controllers: {
       sessions: 'users/sessions',
       registrations: 'users/registrations'
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboard#index'
  
  get '/dashboard' => 'dashboard#index'
  
  get '/musicteacher' => 'teacher_musics#index'
  get '/musicteacherview' => 'teacher_musics#show'
  post '/musicteachersave' => 'teacher_musics#create'
  delete '/musicteacherdel' => 'teacher_musics#delete'
  
  get '/thaimusic' => 'thai_musics#index'
  get '/thaimusicview' => 'thai_musics#show'
  post '/thaimusicsave' => 'thai_musics#create'
  delete '/thaimusicdel' => 'thai_musics#delete'
  
  get '/intermusic' => 'inter_musics#index'
  get '/intermusicview' => 'inter_musics#show'
  post '/intermusicsave' => 'inter_musics#create'
  delete '/intermusicdel' => 'inter_musics#delete'
  
  get '/folkmusic' => 'folk_musics#index'
  get '/folkmusicview' => 'folk_musics#show'
  post '/folkmusicsave' => 'folk_musics#create'
  delete '/folkmusicdel' => 'folk_musics#delete'
  
  get '/admin' => 'admin#index'
  post '/admin' => 'admin#show'
  get '/adminimport' => 'admin#import'
  post '/adminimport' => 'admin#importpost'
  get '/exportto' => 'admin#exportTo'
  
  get "/allschools" => 'schools#allschools'
  get "/getuserinfo" => 'admin#getuserinfo'
  resources :schools , only: [:index]
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  #resources :answers
  #resources :formmanages
  #resources :loghistories
  #resources :musictypes
  #resources :questions
  #resources :schools
  #resources :sessions
  #resources :tanswers
  #resources :tloghistories
  #resources :users
  #resources :schools do
  #  post 'filter', on: :collection
  #end

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
