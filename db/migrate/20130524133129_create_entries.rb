class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.date :date
      t.integer :time
      t.string :description
      t.references :developer
      t.references :project
      t.references :category

      t.timestamps
    end
    add_index :entries, :developer_id
    add_index :entries, :project_id
    add_index :entries, :category_id
  end
end
