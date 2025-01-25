class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.all 
  end

  def show
    @orders = Order.all 
    @order = Order.find(params[:id])
    @orders = Order.where(customer_id:(params[:id]))

    @shipping_cost = 800
  end

  def update
  end
end
