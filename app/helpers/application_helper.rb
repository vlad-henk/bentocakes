module ApplicationHelper
  def current_cart
    @current_cart ||= find_or_create_cart
  end
  
  def cart_items_count
    current_cart.cart_items.sum(:quantity)
  rescue
    0
  end
  
  private
  
  def find_or_create_cart
    if user_signed_in?
      # Для авторизованих користувачів
      current_user.cart || current_user.create_cart
    else
      # Для гостей
      if session[:cart_id]
        Cart.find_by(id: session[:cart_id]) || create_guest_cart
      else
        create_guest_cart
      end
    end
  end
  
  def create_guest_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end