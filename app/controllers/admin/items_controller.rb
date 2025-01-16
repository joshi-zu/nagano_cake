class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @item = Item.new(item_params)
  end

  def show
  end

  def edit
  end

  private
  def item_params
    params.require(:item).permit(:item_id, :name, :introduction, :price, :genre_id)
  end
end
