class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.all 
  end

  def show
    @orders = Order.all 
    @order = Order.find(params[:id])
    @cart_items = CartItem.where(customer_id:(params[:id]))

    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.with_tax_price*cart_item.amount
    end
    @cart_items_price = ary.sum
    @shipping_cost = 800

    @total_price = @shipping_cost + @cart_items_price
  end

  def update
  end
end
