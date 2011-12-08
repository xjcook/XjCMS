class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.boolean :hero
      t.boolean :pages
      t.boolean :stories
      t.boolean :comments

      t.timestamps
    end
  end
end
