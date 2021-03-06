class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.string :description
      t.boolean :active, default: false
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
