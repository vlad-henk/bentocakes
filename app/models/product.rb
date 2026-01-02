class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  
  enum category: {
    cakes: 'cakes',
    desserts: 'desserts',
  }
  
  scope :active, -> { where(active: true) }
  scope :by_category, ->(category) { where(category: category) if category.present? }
end