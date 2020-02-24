class Audit
  def archive!
    self.status = 'archive'

    save && clear_audit
  end

  private

  def clear_audit
    destroy_associated
    unlock_associated!
    update_project_roles
  end

  def destroy_associated
    todos.destroy_all
    destroy_old_attachment_versions
  end

  def unlock_associated!
    attached_documents.reload.each(&:unlock!)
    objectives.each(&:release_lock!)
  end

  def update_project_roles
    project_roles.includes(:relationship).each do |project_role|
      project_role.update_attributes(name: 'reviewer')
    end
  end
end
