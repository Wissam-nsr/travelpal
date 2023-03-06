class CreateMoments < ActiveRecord::Migration[7.0]
  def change
    create_table :moments do |t|
      t.string :description
      t.string :location
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
