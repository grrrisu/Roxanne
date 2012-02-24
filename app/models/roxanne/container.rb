module Roxanne
  class Container < ActiveRecord::Base
    include Sortable

    belongs_to :page
    has_many :contents, :dependent => :destroy
    has_ancestry

    before_validation :set_name_of_parent

    def set_name_of_parent
      if name.blank? && parent.present?
        self.name = parent.name
      end
    end

  end
end