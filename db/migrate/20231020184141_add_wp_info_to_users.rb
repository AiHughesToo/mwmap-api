class AddWpInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :wp_user_id, :integer
  end
end
