# -*- encoding : utf-8 -*-
class CreateUsers < ActiveRecord::Migration  
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.string :email

      t.timestamps
    end
  end
end
