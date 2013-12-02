class Track < ActiveRecord::Base
  COLUMN_NAMES = ["id", "tid", "tname", "tinfo", "tpictureurl"]

  def self.column_names
    return COLUMN_NAMES
  end
end