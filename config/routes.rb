Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/', to: 'health#status'

      resources :products, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
