class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :wp_user_id
      t.string :location_type
      t.string :image
      t.string :web
      t.string :insta
      t.string :faceb
      t.string :email
      t.string :phone
      t.string :calendly

      t.timestamps
    end
  end
end
