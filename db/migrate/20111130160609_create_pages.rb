# -*- encoding : utf-8 -*-
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :author
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
