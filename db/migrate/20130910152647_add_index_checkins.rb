class AddIndexCheckins < ActiveRecord::Migration
  def change
    add_index :checkins, :user_id
    add_index :checkins, :place_id
  end
end
