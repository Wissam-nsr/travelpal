class AddCoordinatesToMoments < ActiveRecord::Migration[7.0]
  def change
    add_column :moments, :latitude, :float
    add_column :moments, :longitude, :float
  end
end
