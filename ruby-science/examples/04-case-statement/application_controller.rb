class ApplicationController
  def current_user
    @current_user ||= User.find(session.to_h)
  end
end
