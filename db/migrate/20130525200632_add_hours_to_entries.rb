class AddHoursToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :hours, :string
  end
end
