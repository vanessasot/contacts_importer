class CreateInvalidContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :invalid_contacts do |t|
      t.string :name
      t.string :birthday
      t.string :telephone
      t.string :address
      t.string :credit_card_number
      t.string :credit_card_franchise
      t.string :credit_card_last_four_digits
      t.string :email
      t.string :error_message
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
