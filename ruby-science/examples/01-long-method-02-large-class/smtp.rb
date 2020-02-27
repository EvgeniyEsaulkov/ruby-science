# file config/initializers/smtp.rb

mail_config = app_settings.mail_config
mail_config = 'office@example.com' if mail_config.blank?
ActionMailer::Base.smtp_settings = SMTP_SETTINGS[mail_config]
