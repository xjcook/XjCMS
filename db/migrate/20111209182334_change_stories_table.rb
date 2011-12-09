class ChangeStoriesTable < ActiveRecord::Migration
  def up
    change_table :stories do |t|
      t.remove :author
      t.references :user
    end
  end
  
  def down
    change_table :stories do |t|
      t.string :author
      t.remove :user_id
    end
  end
end
