# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  
  enum status: {
    pending: 'pending',
    processing: 'processing',
    shipped: 'shipped',
    delivered: 'delivered',
    cancelled: 'cancelled'
  }
  
  validates :delivery_address, :phone, presence: true
  validates :total, numericality: { greater_than: 0 }
  
  after_initialize :set_default_status, if: :new_record?
  
  def items_count
    order_items.sum(:quantity)
  end
  
  private
  
  def set_default_status
    self.status ||= :pending
  end
end