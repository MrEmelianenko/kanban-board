class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings, id: false do |t|
      t.string :key, null: false
      t.text :value, null: false
    end

    add_index :settings, :key, unique: true, using: :btree
  end
end
