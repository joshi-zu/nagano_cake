class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.all 
  end

  def show
    @orders = Order.all 
    @order = Order.find(params[:id])
  end

  def update
  end
end
