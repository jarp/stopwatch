class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :developer
      t.references :project
      t.date :sent_date

      t.timestamps
    end
    add_index :invoices, :developer_id
    add_index :invoices, :project_id
  end
end
