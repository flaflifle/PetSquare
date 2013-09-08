class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :category
      t.string :street
      t.string :city
      t.string :country
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :gmaps, :default => false
      t.timestamps
    end
  end
end
