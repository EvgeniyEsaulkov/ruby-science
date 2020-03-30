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
    if contact.email_hidden?
      "no-reply.#{SecureRandom.uuid}-task-closed@flatstack.com"
    else
      contact.email
    end
  end
end
