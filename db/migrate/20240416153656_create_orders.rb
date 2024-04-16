class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :price, null: false
      t.string :status, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
