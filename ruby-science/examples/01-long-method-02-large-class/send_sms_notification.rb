class SendSmsNotification
  include Interactor

  def call
    context.fail! unless app_settings.gcal_sms_notifier

    logger.info "Sending SMS Notification"

    begin
      SmsNotifier.send_new_order_notification(context.order)
    rescue
      logger.error("SmsNotifier error")
      context.fail!
    end
  end
end
