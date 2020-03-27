class Ticket
  NEW_STATUS = 1

  def confirmed_by?(confirmation_code)
    code == confirmation_code.to_i
  end

  def activate(confirmation_code)
    return false if code != confirmation_code.to_i

    self.status = NEW_STATUS
    save
  end
end
