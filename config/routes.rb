Rails.application.routes.draw do
    root 'pages#homepage'
    devise_for :users
    
    post 'posts/add' => 'posts#create'
end
