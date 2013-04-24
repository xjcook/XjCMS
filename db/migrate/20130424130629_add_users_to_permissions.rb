class AddUsersToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :users, :boolean
  end
end
