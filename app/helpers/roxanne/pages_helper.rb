module Roxanne
  module PagesHelper
  
    def content(page, name)
      page.contents.find {|content| content.name = name}
    end
  
    def navigation_as_collection node = Page.root
      PageDecorator.decorate(node).navigation_as_collection
    end
  
  end
end