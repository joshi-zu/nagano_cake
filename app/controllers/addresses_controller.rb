class AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      flash[:notice] = "すべての項目を入力してください"
      redirect_to addresses_path
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
