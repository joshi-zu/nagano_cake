class OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = Address.all
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @shipping_cost = 800
    @selected_payment_method = params[:order][:payment_method]

    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.with_tax_price*cart_item.amount
    end
    @cart_items_price = ary.sum

    @total_price = @shipping_cost + @cart_items_price
    @select_address = params[:order][:select_address]
    case @select_address
    when "customer_address"
      @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "registered_address"
      unless params[:order][:address_id] == ""
        selected = Address.find(params[:order][:address_id])
        @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address = params[:order][:new_postal_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
      else
        render :new
      end
    end   
  end

  def create
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @cart_items = CartItem.where(customer_id: current_customer.id)
    ary = []
    @cart_items.each do |cart_item|
      ary << cart_item.item.with_tax_price*cart_item.amount
    end
    @cart_items_price = ary.sum
    @order.total_payment = @order.shipping_cost + @cart_items_price
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.order_status = 1
    else
      @order.order_status = 0
    end

    select_address = params[:order][:select_address]
    case select_address
    when "customer_address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    when "registered_address"
      Address.find(params[:order][:registered_address_id])
      selected = Address.find(params[:order][:registered_address_id])
      @order.postal_code = selected.postal_code
      @order.address = selected.address
      @order.name = selected.name
    when "new_address"
      @order.postal_code = params[:order][:new_postal_code]
      @order.address = params[:order][:new_address]
      @order.name = params[:order][:new_name]
    end

    if @order.save
      if @order.order_status == 0
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
        end
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
      render :items
    end
  end

  def thanks
  end

  def index
    @order = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :amount, :customer_id, :shipping_cost, :order_status)
  end
end
