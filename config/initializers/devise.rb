Devise.setup do |config|
  require "devise/orm/active_record"
  config.secret_key = Rails.application.secret_key_base
  config.parent_controller = "ApplicationController"
  config.omniauth :google_oauth2,
    ENV["GOOGLE_OAUTH_CLIENT_ID"], ENV["GOOGLE_OAUTH_CLIENT_SECRET"],
    scope: "email,profile", prompt: "select_account"
  config.sign_out_via = :delete
  config.navigational_formats = [ "*/*", :html, :turbo_stream ]
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
