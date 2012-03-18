module Roxanne
  class ContainerList < Container

    validates :name, :uniqueness => {:scope => [:page_id, :type], :if => :name_present?}
    
    attr_accessor :list # needed for container _form

    def name_present?
      name.present?
    end
  end
end