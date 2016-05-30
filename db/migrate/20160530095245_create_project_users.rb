class CreateProjectUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :project_users, id: :uuid do |t|
      t.references :project, type: :uuid, foreign_key: true
      t.references :user,    type: :uuid, foreign_key: true

      t.integer :access_level, default: nil
    end

    add_index :project_users, [:project_id, :user_id], unique: true
  end
end
