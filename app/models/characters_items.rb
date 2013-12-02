class CharactersItems < ActiveRecord::Base
  COLUMN_NAMES = ["id", "cid", "iid"]

  def self.column_names
    return COLUMN_NAMES
  end
end