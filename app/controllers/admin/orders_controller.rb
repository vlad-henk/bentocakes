# app/controllers/admin/orders_controller.rb
class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:show, :update]
  
  def index
    @orders = Order.all.includes(:user, :order_items).order(created_at: :desc)
  end
  
  def show
  end
  
  def update
    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: 'Статус замовлення оновлено'
    else
      render :show
    end
  end
  
  private
  
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
end
