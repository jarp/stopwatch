class AddInvoiceIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :invoice_id, :integer
  end
end
