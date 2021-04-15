class CreateImportFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :import_files do |t|
      t.string :file
      t.string :status

      t.timestamps
    end
  end
end
