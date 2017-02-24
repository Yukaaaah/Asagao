Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  get "about" => "top#about" ,as: "about"
  get "bad_request" => "top#bad_request"
  get "internal_server_error" => "top#internal_server_error"
  get "lesson/:action(/:name)" => "lesson"
  resources :members , only: [:index, :show] do
      collection {get "search"}   #メンバー検索アクション　メソッドとして指定
  #   #   get "search" , on:collection ともかける
  #     member{patch "suspend", "restore"}            #メンバーの停止・再開アクション
  #   #   put "suspend", "restore" , on: :member ともかける
      resources :entries, only: [:index]
   end

   resources :articles, only: [:index, :show]
   resources :entries do
       member { patch :like, :unlike}
       collection {get :voted}
   end
   resource :session, only: [:create , :destroy]  #ログインとログアウトの時だけ
   resource :account
   # , only: [:show, :edit, :update]

   namespace :admin do
       root to: "top#index", as: "root"
       resources :members do
           collection { get "search"}
       end
       resources :articles
   end

   match "*anything" => "top#not_found", via:[:get , :post, :patch, :delete] #Action Dispatch
end
