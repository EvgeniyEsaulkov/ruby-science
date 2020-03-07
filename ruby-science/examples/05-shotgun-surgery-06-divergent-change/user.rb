class User < ApplicationRecord
  def full_name
    "#{first_name} #{last_name}"
  end

  def email_with_privacy
    return nil if privacy_settings.exists?(hide_email: true)

    email
  end
end
