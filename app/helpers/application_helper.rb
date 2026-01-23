module ApplicationHelper
  def current_cart
    @current_cart ||= find_or_create_cart
  end
  
  def cart_items_count
    current_cart.cart_items.sum(:quantity)
  rescue
    0
  end

  def format_currency(amount)
    number_to_currency(amount, unit: '₴', format: '%n %u')
  end
  
  def status_classes(status)
    case status
    when 'pending'
      'bg-yellow-100 text-yellow-800'
    when 'processing'
      'bg-blue-100 text-blue-800'
    when 'shipped'
      'bg-indigo-100 text-indigo-800'
    when 'delivered'
      'bg-green-100 text-green-800'
    when 'cancelled'
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end
  
  def order_status_text(status)
    case status
    when 'pending'
      'Очікує обробки'
    when 'processing'
      'В обробці'
    when 'shipped'
      'Відправлено'
    when 'delivered'
      'Доставлено'
    when 'cancelled'
      'Скасовано'
    else
      'Невідомий статус'
    end
  end
  
  def format_date(date)
    l(date, format: :long) rescue date.strftime("%d.%m.%Y %H:%M")
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