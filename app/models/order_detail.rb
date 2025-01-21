class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: {impossible_making: 0, wait_making:1, making: 2, finish: 3}
end
