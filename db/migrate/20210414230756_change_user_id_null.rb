class ChangeUserIdNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :contacts, :user_id, false
  end
end
