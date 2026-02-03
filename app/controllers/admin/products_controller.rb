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
    @product = Product.new(product_params.except(:photo))
    
    if params[:product][:photo].present?
      # Завантажуємо фото на Cloudinary
      upload_result = Cloudinary::Uploader.upload(params[:product][:photo])
      @product.photo_url = upload_result['public_id']
    end

    if @product.save
      redirect_to admin_product_path(@product), notice: 'Товар успішно створено'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    # Якщо завантажується нове фото
    if params[:product][:photo].present?
      # Видалити старе фото з Cloudinary (опційно)
      if @product.photo_url.present?
        Cloudinary::Uploader.destroy(@product.photo_url) rescue nil
      end
      
      # Завантажити нове фото
      upload_result = Cloudinary::Uploader.upload(params[:product][:photo])
      @product.photo_url = upload_result['public_id']
    end
    
    if @product.update(product_params.except(:photo))
      redirect_to admin_products_path, notice: 'Товар успішно оновлено'
    else
      render :edit
    end
  end

  def activate
  product = Product.find(params[:id])
  product.update!(active: true)
  redirect_to admin_products_path, notice: 'Товар активовано'
  end

  def deactivate
    product = Product.find(params[:id])
    product.update!(active: false)
    redirect_to admin_products_path, notice: 'Товар деактивовано'
  end
  #def destroy
    #@product.destroy
    #redirect_to admin_products_path, notice: 'Товар видалено'
  #end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :active, :photo)
  end
end