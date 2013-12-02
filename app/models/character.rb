class Character < ActiveRecord::Base
  COLUMN_NAMES = ["id", "cid", "cname", "cinfo", "cpictureurl"]

  def self.column_names
    return COLUMN_NAMES
  end
end