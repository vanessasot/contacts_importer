class AddForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :contacts, :users
  end
end
