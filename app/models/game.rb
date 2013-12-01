class Game < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gid", "gname", "greleasedate", "created_at", "updated_at"]

  def self.column_names
    return COLUMN_NAMES
  end
end