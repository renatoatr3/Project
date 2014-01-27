class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :http_basic_authenticate

  def http_basic_authenticate
    if request.format == :json || current_user == nil
      authenticate_or_request_with_http_basic do |email, password|
        @current_user = User.find_for_database_authentication(:email => URI.unescape(email))
        @current_user.present? ? @current_user.valid_password?(password) : false
      end
    end
  end
end
