class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.references :user, foreign_key: true
      t.references :ngo, foreign_key: true
      t.text :items
      t.date :schedule
      t.text :comments
      t.string :address
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
