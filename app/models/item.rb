class Item < ApplicationRecord
  has_one_attached :item_image

  belongs_to :genre
  has_many :cart_items

  def with_tax_price
    tax_rate = 0.1 # 例として消費税率を10%とします
    price * (1 + tax_rate).round
  end

  def add_tax_price
    (self.price * 1.10).round
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @item = Item.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @item = Item.where("name LIKE?","%#{word}%")
    else
      @item = Item.all
    end
  end
end
