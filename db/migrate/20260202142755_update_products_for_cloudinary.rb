class UpdateProductsForCloudinary < ActiveRecord::Migration[7.2]
  def change
    # Видаляємо старе поле images
    remove_column :products, :images, :string
    
    # Додаємо нове поле для Cloudinary public_id
    add_column :products, :photo_url, :string
  end
end
