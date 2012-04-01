module Roxanne
  module PagesHelper
  
    def content(page, name)
      page.contents.find {|content| content.name = name}
    end
  
    def navigation_as_collection node = Page.root
      PageDecorator.decorate(node).navigation_as_collection
    end
    
    def pages_collection
      find_templates('templates/pages', false)
    end
  
  end
end