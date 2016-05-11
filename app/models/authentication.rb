class Authentication < ApplicationRecord
  cattr_accessor :current

  belongs_to :user

  validates_presence_of :provider
  validates_presence_of :uid
  validates_uniqueness_of :uid, scope: :provider

  serialize :info
  serialize :credentials
  serialize :extra

  class << self
    # Takes an auth hash from OmniAuth and finds or creates an authentication.
    def from_auth_hash(auth_hash)
      auth_hash.symbolize_keys!
      # Find or initialize an authentication based on provider/uid
      auth = find_or_initialize_by(provider: auth_hash.dig(:provider),
                                   uid: auth_hash.dig(:uid))
      # Update attributes based on auth hash
      auth.info        = auth_hash.dig(:info)
      auth.credentials = auth_hash.dig(:credentials)
      auth.extra       = auth_hash.dig(:extra)

      # Delegate setting user to User
      auth.user      ||= User.from_auth_hash(auth_hash)

      # Make sure the authentication is persisted
      auth.save!

      auth
    end
  end
end
