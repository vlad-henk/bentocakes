class AddCartIdToCartItems < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:cart_items, :cart_id)
      add_reference :cart_items, :cart, null: false, foreign_key: true
    end
  end
end
