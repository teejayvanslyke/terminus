class ZineMigration < ActiveRecord::Migration
  def self.up
    create_table :zines do |t|
      t.string :title
  
      t.timestamps
    end
 
  end

  def self.down
    drop_table :zines
  end
end
