class AddRoutetoStep < ActiveRecord::Migration[7.0]
  def change
    add_column :steps, :route, :string
  end
end
