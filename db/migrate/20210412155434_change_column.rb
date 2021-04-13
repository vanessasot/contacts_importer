class ChangeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :birthday, :string
  end
end
