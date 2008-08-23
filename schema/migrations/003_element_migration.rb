class ElementMigration < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.integer :page_id
  
      t.timestamps
    end
 
  end

  def self.down
    drop_table :elements
  end
end
