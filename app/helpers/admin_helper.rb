module AdminHelper
  def order_status_classes(status)
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
end