class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    admin = Admin.from_google(request.env["omniauth.auth"])
    if admin
      sign_out_all_scopes
      flash[:notice] = "Successfully authenticated with Google."
      sign_in_and_redirect admin, event: :authentication
    else
      redirect_to new_admin_session_path, alert: "Google sign-in could not be verified. Please try again."
    end
  end

  def failure
    redirect_to new_admin_session_path, alert: "Google sign-in was cancelled or failed. Please try again."
  end

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
