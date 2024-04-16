class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :address, null: false
      t.string :cover, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :shops, :name
  end
end
