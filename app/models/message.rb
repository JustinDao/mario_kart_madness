class Message < ActiveRecord::Base
  COLUMN_NAMES = ["id", "mid", "text"]

  def self.column_names
    return COLUMN_NAMES
  end
end