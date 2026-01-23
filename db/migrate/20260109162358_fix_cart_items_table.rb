class FixCartItemsTable < ActiveRecord::Migration[7.2]
  def change
    if column_exists?(:cart_items, :user_id)
      remove_column :cart_items, :user_id
    end
    
    unless column_exists?(:cart_items, :cart_id)
      add_reference :cart_items, :cart, null: false, foreign_key: true
    end
    
    add_index :cart_items, [:cart_id, :product_id], unique: true
  end
end
