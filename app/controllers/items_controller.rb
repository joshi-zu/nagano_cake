class ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: true).page(params[:page])
    @total_items = Item.where(is_active: true).count
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
    @genres = Genre.all
  end
end
