module Roxanne
  class User < ActiveRecord::Base
    authenticates_with_sorcery!
  
    attr_accessible :email, :password, :password_confirmation

    validates :password, :presence => true, :confirmation => true, :on => :create
    validates :username, :presence => true, :uniqueness => true
  end
end