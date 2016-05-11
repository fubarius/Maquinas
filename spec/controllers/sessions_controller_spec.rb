require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    it "redirects to root" do
      request.env['omniauth.auth'] = {provider: 'foo', uid: 'bar'}
      post :create, provider: :foo
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to root_url
    end
  end

  describe "DELETE destroy" do
    it "redirects to root" do
      delete :destroy
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to root_url
    end
  end

end
