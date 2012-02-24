module Roxanne
  class ContainerList < Container

    validates :name, :uniqueness => {:scope => [:page_id, :type], :if => :name_present?}

    def name_present?
      name.present?
    end
  end
end