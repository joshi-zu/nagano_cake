class Item < ApplicationRecord
  has_one_attached :item_image

  has_many :cart_items

  def with_tax_price
    tax_rate = 0.1 # 例として消費税率を10%とします
    price * (1 + tax_rate)
  end
end
