class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def manage_authentication
    if session[:authentication_id]
      Authentication.current = Authentication.find_by(id: session[:authentication_id])
    else
      Authentication.current = nil
    end
    yield
  ensure
    session[:authentication_id] = Authentication.current&.id
    Authentication.current = nil
  end
end
