class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.references :user_one, null: false, foreign_key: {to_table: :users}
      t.references :user_two, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
