class OrdersItem < ApplicationRecord
    def change
        create_table :orders_items do |t|
            t.integer :quantity, null: false
            t.references :order, null: false
            t.references :item, null: false
        end
    end
end
