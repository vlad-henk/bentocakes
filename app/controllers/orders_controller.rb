class OrdersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_order, only: [:show]
  
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end
  
  def show
    # @order вже встановлений через before_action
  end
  
  def new
    @order = current_user.orders.new
    @cart = current_cart
    
    if @cart.cart_items.empty?
      redirect_to cart_path, alert: 'Ваш кошик порожній'
    end
  end
  
  def create
    @order = current_user.orders.new(order_params)
    @cart = current_cart
    
    if @cart.cart_items.empty?
      redirect_to cart_path, alert: 'Ваш кошик порожній'
      return
    end
    
    # Простий розрахунок доставки
    delivery_price = 0
    @order.total = @cart.total_price + delivery_price
    
    if @order.save
      # Переносимо товари з кошика в замовлення
      @cart.cart_items.each do |cart_item|
        @order.order_items.create(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end
      
      # Очищаємо кошик
      @cart.cart_items.destroy_all
      
      redirect_to @order, notice: '🎉 Замовлення успішно створено!'
    else
      render :new
    end
  end
  
  private
  
  def set_order
    @order = current_user.orders.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:delivery_address, :phone, :notes)
  end
end