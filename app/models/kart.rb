class Kart < ActiveRecord::Base
  COLUMN_NAMES = ["id", "kid", "kname", "kinfo", "kpictureurl"]

  def self.column_names
    return COLUMN_NAMES
  end
end