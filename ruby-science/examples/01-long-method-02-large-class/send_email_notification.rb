class SendEmailNotification
  include Interactor

  def call
    Notifier.deliver_new_order_notification(
      context.order,
      render_to_string(:template => 'admin/orders/show.xls', :layout => false)
    )
  end
end
