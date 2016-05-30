class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :issue,   type: :uuid, index: true, foreign_key: true
      t.references :creator, type: :uuid, index: true

      t.text :text

      t.timestamps
    end

    add_foreign_key :comments, :users, column: :creator_id
  end
end
