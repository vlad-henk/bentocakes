class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  validates :name, presence: true
  
  after_create :create_cart
  
  private
  
  def create_cart
    Cart.create(user: self)
  end
end