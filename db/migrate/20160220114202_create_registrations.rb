class CreateRegistrations < ActiveRecord::Migration
    def change
        create_table :registrations do |t|
            t.belongs_to :excursion, index:true, foreign_key: true
            t.string :name
            t.integer :phoneNumber
            t.string :email
            t.integer :busSpots
            t.integer :lunchSpots

            t.timestamps null: false
        end
    end
end
