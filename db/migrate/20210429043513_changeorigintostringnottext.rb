class Changeorigintostringnottext < ActiveRecord::Migration[6.1]
  def change
    change_column :bottles, :origin, :string
  end
end
