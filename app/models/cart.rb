class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  
  def total_price
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end
  
  def total_items
    cart_items.sum(:quantity)
  end
end