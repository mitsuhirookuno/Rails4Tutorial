class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.integer :source_type
      t.binary :data, :limit => 5.megabyte
      t.integer :search_word_id

      t.timestamps
    end
    add_index :timelines, [:search_word_id] 
  end
end
