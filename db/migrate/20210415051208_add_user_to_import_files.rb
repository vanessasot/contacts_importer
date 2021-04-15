class AddUserToImportFiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :import_files, :user, null: false, foreign_key: true
  end
end
