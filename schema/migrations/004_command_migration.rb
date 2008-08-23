class CommandMigration < ActiveRecord::Migration
  def self.up
    create_table :commands do |t|
      t.string :name
      t.text   :code
  
      t.timestamps
    end
 
  end

  def self.down
    drop_table :commands
  end
end
