class Ticket
  def confirmed_by?(confirmation_code)
    code == confirmation_code.to_i
  end
end
