class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise:database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_one_attached :item_image

end