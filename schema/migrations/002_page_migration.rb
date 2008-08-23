class PageMigration < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :zine_id
  
      t.timestamps
    end
 
  end

  def self.down
    drop_table :pages
  end
end
