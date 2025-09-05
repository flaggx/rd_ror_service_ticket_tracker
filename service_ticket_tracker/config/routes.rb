Rails.application.routes.draw do
  resources :users

  resources :tickets do
    collection do
      get :board
    end
    member do
      patch :stage, action: :update_stage
    end
  end

  root "tickets#index"
end