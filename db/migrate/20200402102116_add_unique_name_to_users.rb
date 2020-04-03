class AddUniqueNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :unique_name, :string
  end
end
