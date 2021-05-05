class CreateBottles < ActiveRecord::Migration[6.1]
  def change
    create_table :bottles do |t|
      t.string :name
      t.string :type
      t.integer :abv
      t.integer :user_id
    end
  end
end
