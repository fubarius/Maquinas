require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:subject) { FactoryGirl.create(:user) }

  it "has associations" do
    should have_many :authentications
  end

  context '.from_auth_hash' do
    let(:subject) { User.from_auth_hash(auth_hash) }
    let(:auth_hash) do
      {
        provider: 'SomethingClever',
        uid: 'fubarius9180',
        info: {
          name: 'Fubarius Jenkins III',
          email: 'fubarius9180@gmail.com'
        }
      }
    end

    it "should create a user with name and email from auth hash" do
      assert_equal auth_hash.dig(:info, :name), subject.name
      assert_equal auth_hash.dig(:info, :email), subject.email
    end
  end

  context '.current' do
    let(:subject) { User }
    let(:auth) { FactoryGirl.create(:authentication) }
    it "should return the current authentication's user" do
      Authentication.current = auth
      assert_equal auth.user, subject.current
      Authentication.current = nil
    end
    it "should return nil if there is no current authentication" do
      Authentication.current = nil
      assert_nil subject.current
    end
  end
end
