Rails.application.routes.draw do
	namespace :api do
    namespace :v1 do
  		resources :balance_transfers
  		resources :accounts
  		post 'accounts/:id/transfer_money', to: 'accounts#transfer_money'
  		get 'accounts/:id/check_balance', to: 'accounts#check_balance'
  	end
  end
end
