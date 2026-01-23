# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_categories, only: [:index, :show]
  
  def index
    if params[:category].present?
      @products = Product.active.by_category(params[:category])
      @current_category = params[:category]
    else
      @products = Product.active.all
    end
    
    @products = @products.order(created_at: :desc)
  end
  
  def show
    @related_products = Product.active
                              .where(category: @product.category)
                              .where.not(id: @product.id)
                              .limit(3)
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  def set_categories
    @categories = {
      'cakes' => "Тортики",
      'desserts' => "Десерти"
    }
  end
end