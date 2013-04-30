class AddLocaleIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :locale_id, :integer
  end
end
