class GameItems < ActiveRecord::Base
  COLUMN_NAMES = ["id", "gid", "iid"]

  def self.column_names
    return COLUMN_NAMES
  end
end