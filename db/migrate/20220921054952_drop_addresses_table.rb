class DropAddressesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :addresses
  end
end
