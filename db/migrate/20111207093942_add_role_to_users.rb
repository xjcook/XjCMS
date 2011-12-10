# -*- encoding : utf-8 -*-
class AddRoleToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :role
    end

    add_index :users, :role_id
  end
end
