# -*- encoding : utf-8 -*-
class AddAuthorToUsers < ActiveRecord::Migration
  def up
    add_column :users, :author, :string
    
    # add trigger
    execute <<-SQL
      CREATE OR REPLACE FUNCTION author_update() RETURNS trigger AS $author_update$
        BEGIN
          IF (NEW.firstname <> '') AND (NEW.lastname <> '') THEN
            NEW.author = NEW.firstname || ' ' || NEW.lastname;
          ELSE
            NEW.author = '';
          END IF;
          RETURN NEW;
        END;
      $author_update$ LANGUAGE plpgsql;
    SQL
    
    execute <<-SQL
      CREATE TRIGGER author_update BEFORE INSERT OR UPDATE ON users
        FOR EACH ROW EXECUTE PROCEDURE author_update();
    SQL
  end
  
  def down
    remove_column :users, :author
    execute "DROP TRIGGER author_update ON users CASCADE;"
  end
end
