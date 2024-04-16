class CreateOrdersItems < ActiveRecord::Migration[7.1]
  def change
    create_table :orders_items do |t|
      t.integer :quantity, null: false
      t.references :order, null: false
      t.references :item, null: false

      t.timestamps
    end
  end
end
