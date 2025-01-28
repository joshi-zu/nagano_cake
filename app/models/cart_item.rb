class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def subtotal
    amount.to_i * item.price.to_i
  end
end
