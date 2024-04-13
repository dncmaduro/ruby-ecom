class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :name, null: false
      t.date :dob, null: false
      t.string :role, null: false
      t.text :address, null: false
      t.string :phone, null: false

      t.timestamps
    end

    # Add an index for efficient email searching (optional)
    add_index :users, :email
  end
end
