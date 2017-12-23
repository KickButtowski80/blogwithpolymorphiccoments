Rails.application.routes.draw do
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  
  resources :projects, only: [:index]

   devise_for :admins 
  
    # Rails.application.routes.draw do
    # devise_for :admins, controllers: {
    #   sessions: 'admins/sessions'
    # }
    # end
  
  
  
  
  
  resources :articles do
    resources :comments 
  end 
  
  root to: 'welcome#index'
end
