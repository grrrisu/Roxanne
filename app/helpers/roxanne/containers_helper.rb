module Roxanne
  module ContainersHelper

    def containers_collection
      find_templates('templates/containers')
    end

    def lists_collection
      find_templates('templates/lists')
    end

  end
end