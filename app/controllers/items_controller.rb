class ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @total_items = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end
end
