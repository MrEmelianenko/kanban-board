class CreateUserAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accounts, id: :uuid do |t|
      t.references :user, type: :uuid, index: true, foreign_key: true

      t.string :provider
      t.string :uid
      t.jsonb  :data

      t.timestamps
    end

    add_index :user_accounts, [:user_id, :provider, :uid], unique: true
  end
end
