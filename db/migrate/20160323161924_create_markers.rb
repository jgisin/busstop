class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :address
      t.string :title
      t.integer :stop_id

      t.timestamps null: false
    end
  end
end
