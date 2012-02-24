class SorceryRememberMe < ActiveRecord::Migration
  def self.up
    add_column :roxanne_users, :remember_me_token, :string, :default => nil
    add_column :roxanne_users, :remember_me_token_expires_at, :datetime, :default => nil
    
    add_index :roxanne_users, :remember_me_token
  end

  def self.down
    remove_index :roxanne_users, :remember_me_token
    
    remove_column :roxanne_users, :remember_me_token_expires_at
    remove_column :roxanne_users, :remember_me_token
  end
end