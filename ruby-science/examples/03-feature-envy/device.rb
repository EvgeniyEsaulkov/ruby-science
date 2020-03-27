class Device
  def update_information(user)
    self.user_id = user.id
    self.last_sign_in_at = Time.now
    save
  end
end
