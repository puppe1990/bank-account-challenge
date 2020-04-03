Rails.application.routes.draw do
	namespace :api do
    namespace :v1 do
  		resources :balance_transfers
  		post 'balance_transfers/money_transfer', to: 'balance_transfers#money_transfer'
  		get 'balance_transfers/check_balance', to: 'balance_transfers#check_balance'
  		resources :accounts
  	end
  end
end
