class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :marker_id
      t.time :arrival_time
      t.time :departure_time

      t.timestamps null: false
    end
  end
end
