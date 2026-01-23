# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :require_admin
  
  private
  
  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: 'Доступ заборонено. Потрібні права адміністратора.'
    end
  end
end