class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :place_id
      t.integer :user_id
      t.integer :pet_id
      t.text :wayd    #what are you doing?

      t.timestamps
    end
  end
end
