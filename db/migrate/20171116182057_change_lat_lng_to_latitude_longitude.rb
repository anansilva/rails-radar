class ChangeLatLngToLatitudeLongitude < ActiveRecord::Migration[5.0]
  def change
    rename_column :ngos, :lat, :latitude
    rename_column :ngos, :lng, :longitude
  end
end
