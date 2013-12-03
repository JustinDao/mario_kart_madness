class GameKarts < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gid", "kid", "wid"]

  def self.column_names
    return COLUMN_NAMES
  end
end