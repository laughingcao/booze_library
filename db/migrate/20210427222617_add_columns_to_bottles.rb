class AddColumnsToBottles < ActiveRecord::Migration[6.1]
  def change
    add_column :bottles, :origin, :text
    add_column :bottles, :price, :integer
  end
end
