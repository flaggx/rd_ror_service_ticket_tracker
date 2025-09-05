class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_basic_auth

  private

  def require_basic_auth
    # Do NOT skip in development/test so you always get the prompt
    user = ENV["TEAM_BASIC_USER"] || Rails.application.credentials.dig(:team_auth, :username)
    pass = ENV["TEAM_BASIC_PASS"] || Rails.application.credentials.dig(:team_auth, :password)

    # If creds aren’t configured, still prompt (fail closed)
    if user.blank? || pass.blank?
      Rails.logger.warn("[BasicAuth] TEAM_BASIC_USER/PASS or credentials.team_auth.* missing; prompting anyway")
    end

    authenticate_or_request_with_http_basic("Restricted") do |u, p|
      ActiveSupport::SecurityUtils.secure_compare(u.to_s, user.to_s) &&
        ActiveSupport::SecurityUtils.secure_compare(p.to_s, pass.to_s)
    end
  end
end