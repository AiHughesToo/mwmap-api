class RemoveColumnFromLocations < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :services
    add_column :locations, :service_types, :string, array: true, default: []
  end
end
