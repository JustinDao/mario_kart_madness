class CharacterKarts < ActiveRecord::Base
  COLUMN_NAMES = ["id", "cid", "kid"]

  def self.column_names
    return COLUMN_NAMES
  end
end