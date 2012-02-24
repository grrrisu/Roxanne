# This migration comes from roxanne (originally 20111112110203)
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
