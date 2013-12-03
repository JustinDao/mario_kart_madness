class User < ActiveRecord::Base
  COLUMN_NAMES = ["id", "username", "password", "admin"]

  validates_uniqueness_of :username

  def self.column_names
    return COLUMN_NAMES
  end
end