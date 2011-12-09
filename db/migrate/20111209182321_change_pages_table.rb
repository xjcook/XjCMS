class ChangePagesTable < ActiveRecord::Migration
  def up
    change_table :pages do |t|
      t.remove :author
      t.references :user
    end
  end
  
  def down
    change_table :pages do |t|
      t.string :author
      t.remove :user_id
    end
  end
end
