class AddTosToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :coi, :boolean, :default => false
  end
end
