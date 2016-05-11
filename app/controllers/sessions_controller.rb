class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def new
    @providers = OmniAuth.strategies.map { |s| s.to_s.split('::').last }
  end

  def create
    Authentication.current = Authentication.from_auth_hash(auth_hash)

    redirect_to root_url, notice: t('.signed_in')
  end

  def destroy
    Authentication.current = nil

    redirect_to root_url, notice: t('.signed_out')
  end

  protected

  def auth_hash
    request.env['omniauth.auth']||{}
  end
end
