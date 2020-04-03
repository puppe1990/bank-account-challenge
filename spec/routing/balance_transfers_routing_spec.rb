require "rails_helper"

RSpec.describe BalanceTransfersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/balance_transfers").to route_to("balance_transfers#index")
    end

    it "routes to #show" do
      expect(:get => "/balance_transfers/1").to route_to("balance_transfers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/balance_transfers").to route_to("balance_transfers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/balance_transfers/1").to route_to("balance_transfers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/balance_transfers/1").to route_to("balance_transfers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/balance_transfers/1").to route_to("balance_transfers#destroy", :id => "1")
    end
  end
end
