class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    last_name + '' + first_name
  end
  
  def full_name_kana
    last_name_kana + '' + first_name_kana
  end
  
  def customer_status
    if is_deleted == false
      "有効"
    else
      "退会"
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  has_many :cart_items
  
end
