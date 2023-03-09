class AddGeocoderObjectToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :geocoder_object, :json
  end
end
