class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :avatar_url, default: nil

      t.string :password_digest
      t.string :authentication_token

      t.integer :state,       default: nil
      t.jsonb   :permissions, default: nil

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
