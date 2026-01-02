class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  after_create :create_user_cart
  
  private
  
  def create_user_cart
    Cart.create(user: self)
  end
end