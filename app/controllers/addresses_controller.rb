class AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_image.address
  end

  def edit
  end
end
