require 'rails_helper'

RSpec.describe Authentication, :type => :model do
  let(:subject) { FactoryGirl.create(:authentication) }

  it "has associations" do
    should belong_to :user
  end

  it "has validations" do
    should validate_presence_of :provider
    should validate_presence_of :uid
    should validate_uniqueness_of(:uid).scoped_to(:provider)
  end

  context ".from_auth_hash" do
    let(:subject) { Authentication.from_auth_hash(auth_hash) }
    let(:auth_hash) do
      {
        provider: 'SomethingClever',
        uid: 'fubarius9180',
        info: {
          name: 'Fubarius Jenkins III',
          email: 'fubarius9180@gmail.com'
        },
        credentials: {
          foo: 'foo',
          bar: 'bar'
        },
        extra: {
          yadda: 'yadda',
          foo: {
            bar: 'bas',
            baz: 'foo'
          }
        }
      }
    end
    it "should create an authentication when no match" do
      assert subject.is_a?(Authentication)
      assert_equal auth_hash.dig(:provider), subject.provider
      assert_equal auth_hash.dig(:uid), subject.uid
      assert_equal auth_hash.dig(:info), subject.info
      assert_equal auth_hash.dig(:credentials), subject.credentials
      assert_equal auth_hash.dig(:extra), subject.extra
      assert subject.user.is_a?(User)
    end

    it "should update an existing authentication when matched" do
      auth_id = FactoryGirl.create(:authentication, provider: auth_hash.dig(:provider), uid: auth_hash.dig(:uid)).id
      assert_equal auth_id, subject.id
      assert_equal auth_hash.dig(:info), subject.info
      assert_equal auth_hash.dig(:credentials), subject.credentials
      assert_equal auth_hash.dig(:extra), subject.extra
    end
  end
end
