class SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    @items = Item.looks(params[:search], params[:word])
  end

end
