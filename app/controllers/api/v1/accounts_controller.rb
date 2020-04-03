class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy, :check_balance, :transfer_money]
  before_action :tranfer_money_params, only: [:transfer_money]

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end

  def check_balance
    calculate_balance
    render json: { 'balance': @balance }
  end

  def transfer_money
    calculate_balance
    if @balance.positive?
      @source_transfer = BalanceTransfer.new(amount: -(params[:amount]), account_id: params[:source_account])
      @destination_transfer = BalanceTransfer.new(amount: params[:amount], account_id: params[:destination_account])
      if @source_transfer.save && @destination_transfer.save
        render json: { 'transfer': true }
      else
        render json: { 'transfer': false }, status: :unprocessable_entity
      end
    else
      render json: { 'transfer': false }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    def tranfer_money_params
      params.permit(:id, :amount, :source_account, :destination_account)
    end

    def calculate_balance
      balance_transfers = BalanceTransfer.where(account_id: @account)
      @balance = balance_transfers.map(&:amount).sum
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.fetch(:account, {})
    end
end
