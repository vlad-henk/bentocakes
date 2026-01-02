# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
    # Отримуємо популярні товари (наприклад, останні 3 активні товари)
    @popular_products = Product.active.limit(3)
  end
  
  def about
  end
  
  def contact
  end
  
  def delivery
  end
end