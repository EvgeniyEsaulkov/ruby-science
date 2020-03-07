class TaskClosedMailer < ActionMailer::Base
  def message(contact, task, user)
    return if user.id == contact.id

    mail(
      to: user.email,
      subject: "Task #{task.name} is closed by #{contact.full_name}",
      from: from(contact)
    )
  end

  private

  def from(contact)
    contact.email_with_privacy || "no-reply.#{SecureRandom.uuid}-task-closed@flatstack.com"
  end
end
