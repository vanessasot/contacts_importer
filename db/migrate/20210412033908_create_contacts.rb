class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.date :birthday
      t.string :telephone
      t.string :address
      t.string :credit_card_number
      t.string :credit_card_franchise
      t.string :email

      t.timestamps
    end
  end
end
