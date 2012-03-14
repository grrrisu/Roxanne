# encoding: UTF-8
module Roxanne
  class PageDecorator < ApplicationDecorator
    decorates "Roxanne::Page"

    def render_list(name)
      decorater = get_container(name) do
        ContainerList.new :name => name, :page => model, :template => 'list', :page => model
      end
    end

    def render_container(name, template)
      decorater = get_container(name) do
        Container.create :name => name, :template => template, :page => model
      end
    end

    def navigation_as_collection(depth = nil)
      model.sorted_subtree(depth).inject({}) do |hash, node|
        name = "⋅"*node.depth + "• #{node.title}"
        hash[name] = node.id
        hash
      end
    end

    def render_navigation(template, options)
      subtree_root = options[:node] || Page.root
      navigation   = subtree_root.sorted_subtree(options[:depth])
      breadcrumbs  = model.ancestors << model
      helpers.render "templates/pages/#{template}", navigation: navigation, breadcrumbs: breadcrumbs
    end

  private

    def get_container(name)
      # if current_user.can :manage, Container
      unless container = model.containers.find_by_name(name)
        container = yield
        #model.containers << container
      end
      decorator = ContainerDecorator.decorate(container)
      decorator.render
    end

  end
end