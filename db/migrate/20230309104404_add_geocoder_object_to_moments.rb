class AddGeocoderObjectToMoments < ActiveRecord::Migration[7.0]
  def change
    add_column :moments, :geocoder_object, :json
  end
end
