Rails.application.routes.draw do
  resources :users

  resources :tickets do
    collection { get :board }
    member { patch :stage, action: :update_stage }
    resources :ticket_updates, only: [:create, :destroy]
  end

  root "tickets#index"
end