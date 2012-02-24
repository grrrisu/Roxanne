# encoding: UTF-8
module Roxanne
  class PageDecorator < ApplicationDecorator
    decorates "Roxanne::Page"

    def render_section(name)
      render(name) do
        ContainerList.create :name => name, :page => model
      end
    end

    def render_container(name, template)
      render(name) do
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
      helpers.render template, navigation: navigation, breadcrumbs: breadcrumbs
    end

  private

    def render(name)
      # if current_user.can :manage, Container
      unless container = model.containers.find_by_name(name)
        container = yield
        model.containers << container
      end
      decorator = ContainerDecorator.decorate(container)
      decorator.render
    end

  end
end