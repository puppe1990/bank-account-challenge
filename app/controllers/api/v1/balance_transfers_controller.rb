class Api::V1::BalanceTransfersController < ApplicationController
  before_action :set_balance_transfer, only: [:show, :update, :destroy]

  # GET /balance_transfers
  def index
    @balance_transfers = BalanceTransfer.all

    render json: @balance_transfers
  end

  # GET /balance_transfers/1
  def show
    render json: @balance_transfer
  end

  # POST /balance_transfers
  def create
    @balance_transfer = BalanceTransfer.new(balance_transfer_params)

    if @balance_transfer.save
      render json: @balance_transfer, status: :created, location: @balance_transfer
    else
      render json: @balance_transfer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /balance_transfers/1
  def update
    if @balance_transfer.update(balance_transfer_params)
      render json: @balance_transfer
    else
      render json: @balance_transfer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /balance_transfers/1
  def destroy
    @balance_transfer.destroy
  end

  def transfer_money
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance_transfer
      @balance_transfer = BalanceTransfer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def balance_transfer_params
      params.require(:balance_transfer).permit(:amount, :source_account, :destination_account)
    end
end
