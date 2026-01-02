# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy, :clear]
  
  def show
    # Метод show вже має @cart завдяки before_action
  end
  
  def update
    # Логіка оновлення корзини
    # Наприклад, зміна кількості товарів
    redirect_to cart_path, notice: 'Корзину оновлено'
  end
  
  def destroy
    # Очищення корзини
    @cart.cart_items.destroy_all if @cart
    redirect_to cart_path, notice: 'Корзину очищено'
  end
  
  def add_item
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i || 1
    
    # Знаходимо або створюємо запис у корзині
    cart_item = current_cart.cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity = cart_item.persisted? ? cart_item.quantity + quantity : quantity
    
    if cart_item.save
      redirect_back fallback_location: products_path, notice: 'Товар додано до корзини'
    else
      redirect_back fallback_location: products_path, alert: 'Не вдалося додати товар'
    end
  end
  
  def remove_item
    cart_item = current_cart.cart_items.find(params[:item_id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Товар видалено з корзини'
  end
  
  def clear
    current_cart.cart_items.destroy_all
    redirect_to cart_path, notice: 'Корзину очищено'
  end
  
  private
  
  def set_cart
    @cart = current_cart
  end
  
  def current_cart
    if user_signed_in?
      current_user.cart || current_user.create_cart
    else
      if session[:cart_id]
        Cart.find_by(id: session[:cart_id])
      else
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
      end
    end
  end
end