class CreateContents < ActiveRecord::Migration
  def change
    create_table :roxanne_contents do |t|
      t.string :name
      t.integer :container_id
      t.text :text
      t.timestamps
    end
  end
end
