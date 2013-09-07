class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :namePet
      t.string :breed
      t.string :description

      t.timestamps
    end
  end
end
