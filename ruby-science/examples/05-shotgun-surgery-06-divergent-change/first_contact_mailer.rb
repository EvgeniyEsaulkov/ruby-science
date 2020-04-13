class FirstContactMailer < ActionMailer::Base
  def message(user, contact)
    return if user.id == contact.id

    mail(
      to: contact.email,
      subject: "Hello from #{user.full_name}",
      from: from
    )
  end

  private

  def from
    "no-reply.#{SecureRandom.uuid}-first-contact@flatstack.com"
  end
end
