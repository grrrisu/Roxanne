# encoding: UTF-8
module Roxanne
  class PageDecorator < ApplicationDecorator
    delegate_all

    # ----- refactor start ------

    # if template is nil we will ask the user which container he wants to add
    # otherwise we use the template and add the child container directly
    def render_list(name, template = nil, container_tag = 'div')
      list = model.container_lists
                  .where(name: name)
                  .first_or_initialize

      helpers.content_tag(container_tag, class: 'container_list') do
        output = edit_mode? ? add_container_before : ''
        output += list.children.map do |child|
          child.decorate.render_with_template(template)
        end
      end
    end

    def render_content(name, template = 'simple')
      container = model.containers
                       .where(name: name)
                       .first_or_initialize(template: template)
      content = container.where(name: name).first_or_initialize
      content.decorate.render_with_template(template)
    end


    # ----- refactor end ------

    def render_list(name, template = nil)
      decorater = get_container(name) do
        if template
          ContainerList.create :name => name, :page => model, :template => template
        else
          ContainerList.new :name => name, :page => model, :template => 'list'
        end
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

    # options
    # * node     subtree of node (default root)
    # * depth    depth starting from root (default all)
    # * start    filter nodes starting at depth
    def render_navigation(template, options)
      breadcrumbs  = model.ancestors << model
      if options[:start]
        subtree_root = breadcrumbs.find {|node| node.depth == options[:start] - 1}
      else
        subtree_root = options[:node] || Page.root
      end
      navigation   = subtree_root.sorted_subtree(options[:depth])
      navigation   = navigation.find_all{|page| page.depth >= options[:start]} if options[:start]

      helpers.render "templates/pages/#{template}", navigation: navigation, breadcrumbs: breadcrumbs, root: subtree_root
    end

  private

    def get_container(name)
      # if current_user.can :manage, Container
      unless container = model.containers.find_by_name(name)
        container = yield
        model.containers << container unless container.new_record?
      end
      decorator = ContainerDecorator.decorate(container)
      decorator.render
    end

  end
end
