module Roxanne
  class Content < ActiveRecord::Base
    belongs_to :container
    validates :name, :uniqueness => {:scope => :container_id}
  end
end