class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  enum payment_method: {credit_card: 0, transfer: 1}
  enum order_status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  def total_payment
    self.order_details.sum { |detail| detail.price * detail.amount }
  end

end
