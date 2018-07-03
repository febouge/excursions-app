class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.integer :phoneNumber
      t.string :email
      t.boolean :active
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
