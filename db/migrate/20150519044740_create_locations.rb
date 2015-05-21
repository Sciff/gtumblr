class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.string :address
      t.integer :user_id, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
    add_index :locations, :user_id
  end
end
