class AddIndexesToPermissionsRolesTable < ActiveRecord::Migration
  def change
    add_index :permissions_roles, :permission_id
    add_index :permissions_roles, :role_id
  end
end
