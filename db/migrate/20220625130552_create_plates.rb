class CreatePlates < ActiveRecord::Migration[7.0]
  def change
    create_table :plates do |t|
      t.string :name
      t.string :description
      t.string :category
      t.integer :price
      t.integer :discount_price
      t.boolean :discount_active, default: false
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
