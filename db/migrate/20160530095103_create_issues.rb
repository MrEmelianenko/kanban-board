class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues, id: :uuid do |t|
      t.references :project,     type: :uuid, index: true, foreign_key: true
      t.references :creator,     type: :uuid, index: true
      t.references :assigned_to, type: :uuid, index: true
      t.references :issue_type,  type: :uuid, index: true, foreign_key: true

      t.string   :title, null: false
      t.text     :description
      t.integer  :priority, default: nil
      t.integer  :estimate, default: nil

      t.integer  :state,        default: nil
      t.datetime :started_at,   default: nil
      t.datetime :completed_at, default: nil
      t.integer  :position, null: false

      t.timestamps
    end

    add_foreign_key :issues, :users, column: :creator_id
  end
end
