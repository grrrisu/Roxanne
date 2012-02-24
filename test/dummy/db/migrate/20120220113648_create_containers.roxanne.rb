# This migration comes from roxanne (originally 20111114221539)
class CreateContainers < ActiveRecord::Migration
  def change
    create_table :roxanne_containers do |t|
      t.string :type
      t.string :name
      t.integer :page_id
      t.string :template
      t.string :ancestry
      t.integer :sort
      t.timestamps
    end

    add_index :roxanne_containers, :ancestry
  end
end
