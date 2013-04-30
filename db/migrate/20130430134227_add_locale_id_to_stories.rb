class AddLocaleIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :locale_id, :integer
  end
end
