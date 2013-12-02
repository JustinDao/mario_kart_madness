class Weight < ActiveRecord::Base
  COLUMN_NAMES = ["id", "wid", "wname"]

  def self.column_names
    return COLUMN_NAMES
  end
end