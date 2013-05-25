class AddRateToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :rate, :integer
  end
end
