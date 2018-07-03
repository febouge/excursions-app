class CreateExcursions < ActiveRecord::Migration
  def change
    create_table :excursions do |t|
      t.string :name
      t.integer :busSpots
      t.integer :lunchSpots
      t.boolean :active

      t.timestamps null: false
    end
  end
end
