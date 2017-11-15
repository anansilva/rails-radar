class AddPhotoToNgos < ActiveRecord::Migration[5.0]
  def change
    add_column :ngos, :photo, :string
  end
end
