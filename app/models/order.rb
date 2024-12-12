class Order < ApplicationRecord
  validates :customer_email, :total, :address, presence: true

  has_many :order_products
end
