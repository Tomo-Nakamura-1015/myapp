class ChangeColumnToAllowNull < ActiveRecord::Migration[6.0]
  def up
      
    change_column_null :users, :unique_name, :string, null: true
  end

  def down
    change_column_null :users, :unique_name,:string, null: false
  end
end
