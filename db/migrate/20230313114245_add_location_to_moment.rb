class AddLocationToMoment < ActiveRecord::Migration[7.0]
  def change
    add_column :moments, :location, :string
  end
end
