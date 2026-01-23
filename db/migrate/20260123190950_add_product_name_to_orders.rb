class AddProductNameToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :product_name, :string
  end
end
