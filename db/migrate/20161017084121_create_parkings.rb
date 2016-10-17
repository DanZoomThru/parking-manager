class CreateParkings < ActiveRecord::Migration[5.0]
  def change
    create_table :parkings do |t|
      t.float :lat
      t.float :lng
      t.string :name
      t.string :address
      t.boolean :available
      t.string :slug
      t.boolean :has_camera
      t.boolean :has_watchman
      t.string :zip_code
      t.string :district
      t.string :city
      t.string :main_picture
      t.integer :price_month

      t.timestamps
    end
  end
end
