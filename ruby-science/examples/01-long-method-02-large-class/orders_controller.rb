class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = build_order

    if @order.save
      complete_order

      flash[:new_order] = true
      redirect_to @order
    else
      flash[:error] = "Необходимо заполнить поля подсвеченные красным"
      render 'new'
    end
  end

  def show
    find_order

    render_not_found_page unless @order
  end

  def index
    @orders = Order.find(user_orders)
    user_orders_update(@orders)
  end

  private

  def build_order
    order = Order.new(params[:order])
    order.order_items = basket.order_items

    order
  end

  def complete_order
    basket.remove_order_items(@order)
    user_orders << @order.string_id
    send_notifications
  end

  def find_order
    return unless user_orders.include?(params[:id])

    @order = Order.find(params[:id])
  end

  def send_notifications
    SendEmailNotification.call(order: @order)
    SendSmsNotification.call(order: @order)
  end

  def user_orders
    session[:orders] ||= []
  end

  def user_orders_update(orders)
    session[:orders] = orders.map(&:string_id)
  end

  def render_not_found_page
    render :file => "public/404.html", :layout => false, :status => 404
  end
end
