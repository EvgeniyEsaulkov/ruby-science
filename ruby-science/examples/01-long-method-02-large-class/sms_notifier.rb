class SmsNotifier
  def self.send_new_order_notification(order, gcal_login = nil, gcal_password = nil)
    gcal_login ||= 'office@example.com'
    gcal_password ||= SMTP_SETTINGS['office@example.com'][:password]
  end
end
