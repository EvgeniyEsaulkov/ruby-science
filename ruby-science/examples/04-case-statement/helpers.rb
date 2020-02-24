def source_procedure_label(object)
  audit = object.audit || current_audit

  if object.respond_to?(:source_procedure_label)
    h(object.source_procedure_label(audit))
  else
    t("app.source_procedure.#{object.target_key}", :term_for_project => audit.term_for_project)
  end
end
