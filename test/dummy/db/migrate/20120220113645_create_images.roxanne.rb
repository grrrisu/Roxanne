# This migration comes from roxanne (originally 20111111232704)
class CreateImages < ActiveRecord::Migration
  def change
    create_table :mercury_images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
  end
end
