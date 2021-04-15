class ChangeUserIdNullFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :user_id, :bigint, null:false
  end
end
