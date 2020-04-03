Rails.application.routes.draw do
	namespace :api do
    namespace :v1 do
  		resources :balance_transfers
  		post 'balance_transfers/money_transfer', to: 'balance_transfers#money_transfer'
  		resources :accounts
  	end
  end
end
