class Admins::SessionsController < Devise::SessionsController
  def new
    render "admins/sessions/new"
  end

  protected

  def after_sign_out_path_for(_resource_or_scope)
    new_admin_session_path
  end
end
