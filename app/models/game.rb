class Game < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gid", "gname", "greleasedate", "ginfo", "gpictureurl"]

  def self.column_names
    return COLUMN_NAMES
  end
end