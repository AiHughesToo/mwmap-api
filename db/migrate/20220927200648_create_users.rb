class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :password
      t.string :account_type

      t.timestamps
    end
  end
end
