class ChangeColumnToUsersUniqueName < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :unique_name, false
  end
end
