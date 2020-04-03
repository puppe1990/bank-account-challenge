require 'rails_helper'

RSpec.describe "BalanceTransfers", type: :request do
  describe "GET /balance_transfers" do
    it "works! (now write some real specs)" do
      get balance_transfers_path
      expect(response).to have_http_status(200)
    end
  end
end
