class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :description
      t.boolean :ended
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
