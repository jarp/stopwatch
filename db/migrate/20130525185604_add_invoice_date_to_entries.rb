class AddInvoiceDateToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :invoice_date, :date
  end
end
