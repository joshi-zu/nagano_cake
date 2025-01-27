class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: {impossible_making: 0, wait_making:1, making: 2, finish: 3}

  after_save :update_order_status

  def update_order_status
    if self.class.where(order_id: order_id, making_status: :making).exists?
      order.update(order_status: :making)
    elsif self.class.where(order_id: order_id, making_status: :finish).count == self.class.where(order_id: order_id).count
      order.update(order_status: :preparing_ship)
    else
      order.update(order_status: :wait_payment)
    end
  end
end
