class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_validation :set_user, on: :create

  private
  def set_user
    self.user ||= User.current if self.respond_to?(:user)
  end
end
