class Admin::DashboardController < Admin::BaseController
  def index
    @orders_count = Order.count
    @products_count = Product.count
    @users_count = User.count
    @recent_orders = Order.order(created_at: :desc).limit(5)
    @pending_orders = Order.where(status: 'pending').count
    @pruduct_name = Product.name
  end
end