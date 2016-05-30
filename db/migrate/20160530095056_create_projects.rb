class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.references :creator, type: :uuid, index: true

      t.string :name
      t.string :description

      t.timestamps
    end

    add_foreign_key :projects, :users, column: :creator_id
  end
end
