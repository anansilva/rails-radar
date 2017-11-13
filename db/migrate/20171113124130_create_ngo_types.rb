class CreateNgoTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :ngo_types do |t|
      t.references :ngo, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
