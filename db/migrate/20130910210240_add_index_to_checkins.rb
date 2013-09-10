class AddIndexToCheckins < ActiveRecord::Migration
  def change
    add_index :checkins, :pet_id
  end
end
