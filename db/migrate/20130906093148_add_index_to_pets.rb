class AddIndexToPets < ActiveRecord::Migration
  def change
    add_index :pets, :user_id
  end
end
