class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path
  end

  def index
    @item = Item.new
    @items = Item.all
  end

  def show
  end

  def edit
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :genre_id, :item_image)
  end
end
