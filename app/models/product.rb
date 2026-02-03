class Product < ApplicationRecord
  attr_accessor :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  
  enum category: {
    cakes: 'cakes',
    desserts: 'desserts',
  }
  
  scope :active, -> { where(active: true) }
  scope :by_category, ->(category) { where(category: category) if category.present? }

  # Метод для отримання URL фото
  def photo_url(size = nil)
    return nil unless self[:photo_url].present?
    
    case size
    when :thumb
      Cloudinary::Utils.cloudinary_url(self[:photo_url], width: 200, height: 200, crop: :fill)
    when :medium
      Cloudinary::Utils.cloudinary_url(self[:photo_url], width: 400, height: 300, crop: :fill)
    else
      Cloudinary::Utils.cloudinary_url(self[:photo_url])
    end
  end
end