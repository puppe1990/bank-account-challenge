class Api::V1::BalanceTransfersController < ApplicationController
  before_action :set_balance_transfer, only: [:show, :update, :destroy]
  before_action :tranfer_money_params, only: [:transfer_money]
  before_action :check_balance_params, only: [:check_balance]

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
    with_lock do
      @balance_transfer = BalanceTransfer.new(balance_transfer_params)

      if @balance_transfer.save
        render json: @balance_transfer, status: :created, location: @balance_transfer
      else
        render json: @balance_transfer.errors, status: :unprocessable_entity
      end
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
    @account_id = params[:source_account]
    calculate_balance
    if @balance.positive?
      BalanceTransfer.create(amount: -(params[:amount]), account_id: params[:source_account])
      BalanceTransfer.create(amount: params[:amount], account_id: params[:destination_account])
    else
      render json: @balance_transfer.errors, status: :unprocessable_entity
    end
  end

  def check_balance
    @account_id = params[:account_id]
    calculate_balance
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance_transfer
      @balance_transfer = BalanceTransfer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def balance_transfer_params
      params.require(:balance_transfer).permit(:amount, :account_id)
    end    

    def tranfer_money_params
      params.require(:balance_transfer).permit(:amount, :source_account, :destination_account)
    end    

    def check_balance_params
      params.require(:balance_transfer).permit(:account_id)
    end

    def calculate_balance
      balance_transfers = BalanceTransfer.where(account_id: @account_id)
      @balance = balance_transfers.map(&:amount).sum
    end
end
