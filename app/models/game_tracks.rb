class GameTracks < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gid", "tid"]

  def self.column_names
    return COLUMN_NAMES
  end
end