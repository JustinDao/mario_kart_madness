class Console < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gcid", "gcname", "gcinfo", "gcpictureurl"]

  def self.column_names
    return COLUMN_NAMES
  end
end