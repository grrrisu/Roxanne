# This migration comes from roxanne (originally 20111112110110)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :roxanne_pages do |t|
      t.string :title
      t.string :uri
      t.string :layout
      t.string :ancestry
      t.integer :sort
      t.integer :depth, :default => 0
      t.timestamps
    end

    add_index :roxanne_pages, :ancestry
  end
end
