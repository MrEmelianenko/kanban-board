class CreateIssueTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :issue_types, id: :uuid do |t|
      t.string :name
    end
  end
end
