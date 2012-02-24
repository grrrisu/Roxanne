class SorceryResetPassword < ActiveRecord::Migration
  def self.up
    add_column :roxanne_users, :reset_password_token, :string, :default => nil
    add_column :roxanne_users, :reset_password_token_expires_at, :datetime, :default => nil
    add_column :roxanne_users, :reset_password_email_sent_at, :datetime, :default => nil
    
    add_index :roxanne_users, :reset_password_token
  end

  def self.down
    remove_index :roxanne_users, :reset_password_token
    
    remove_column :roxanne_users, :reset_password_email_sent_at
    remove_column :roxanne_users, :reset_password_token_expires_at
    remove_column :roxanne_users, :reset_password_token
  end
end