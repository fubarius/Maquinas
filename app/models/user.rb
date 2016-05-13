class User < ApplicationRecord
  has_many :authentications

  enum group: [:standard, :admin]

  def display_name
    n = name || nickname
    n += " [admin]" if admin?
    n
  end

  class << self
    # Create a user from an auth hash.
    def from_auth_hash(auth_hash)
      auth_hash.symbolize_keys!
      User.create!(name: auth_hash.dig(:info, :name),
                   email: auth_hash.dig(:info, :email))
    end

    def current
      Authentication.current&.user
    end
  end
end
