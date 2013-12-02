class ConsoleGames < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gcid", "gid"]

  def self.column_names
    return COLUMN_NAMES
  end
end