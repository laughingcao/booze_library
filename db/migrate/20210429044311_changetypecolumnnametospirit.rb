class Changetypecolumnnametospirit < ActiveRecord::Migration[6.1]
  def change
    rename_column :bottles, :type, :spirit
  end
end
