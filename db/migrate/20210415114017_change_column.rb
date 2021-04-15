class ChangeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :import_files, :file, :filename
    rename_column :import_files, :status, :state
  end
end
