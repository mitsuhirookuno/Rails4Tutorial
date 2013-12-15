class CreateSearchWords < ActiveRecord::Migration
  def change
    create_table :search_words do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end
