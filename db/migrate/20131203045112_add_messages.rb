class AddMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :mid
      t.string :text, :limit => 140
    end

    create_table :user_messages do |t|
      t.string :username
      t.integer :mid
    end
  end
end
