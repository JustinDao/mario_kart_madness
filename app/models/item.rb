class Item < ActiveRecord::Base
  COLUMN_NAMES = ["id", "iid", "iname", "iinfo", "ipictureurl"]

  def self.column_names
    return COLUMN_NAMES
  end
end