class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :image, null: false
      t.integer :price, null: false
      t.references :shop, null: false, foreign_key: true
    
      t.timestamps
    end

    add_index :items, :name
  end
end
