# app/controllers/admin/products_controller.rb
class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.all.order(created_at: :desc)
  end
  
  def show
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to admin_product_path(@product), notice: 'Товар успішно створено'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Товар успішно оновлено'
    else
      render :edit
    end
  end
  
  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Товар успішно видалено'
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :active)
  end
end