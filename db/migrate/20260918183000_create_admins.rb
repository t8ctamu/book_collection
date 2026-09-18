class CreateAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :admins do |t|
      t.string :uid, null: false
      t.string :email, null: false
      t.string :full_name
      t.timestamps
    end
    add_index :admins, :uid, unique: true
  end
end
