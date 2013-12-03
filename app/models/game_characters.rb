class GameCharacters < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gid", "cid", "wid"]

  def self.column_names
    return COLUMN_NAMES
  end
end