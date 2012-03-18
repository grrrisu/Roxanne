module Roxanne
  class ContainerDecorator < ApplicationDecorator
    decorates "Roxanne::Container"

    def render
      if model.instance_of? ContainerList
        render_list
      else
        render_container
      end
    end
=begin
    def template_selection
      child = Container.new :name => name
      if model.instance_of? ContainerList
        locals = {:parent => model, :sibling => nil}
      else
        locals = {:parent => model.parent, :sibling => model}
      end
      helpers.render 'containers/template_selection', locals.merge(:container => child)
    end
=end
    def add_container_link
      if helpers.current_user
        data = {:name => model.name}
        if model.instance_of? ContainerList
          if model.new_record?
            data[:page] = model.page.id
          else
            data[:parent] = model.id
          end
        else
          data[:sibling] = model.id
        end
        helpers.content_tag 'a', '',
                   :id => "before_#{id}",
                   :href => "#", :onclick => "return false;", :class => "add_container",
                   :data => data
      else
        ''
      end
    end

    def find_template(directory)
      if edit_mode? && helpers.controller.template_exists?("#{model.template}_edit", [directory], true)
        "#{directory}/#{model.template}_edit"
      elsif helpers.controller.template_exists?(model.template, [directory], true)
        "#{directory}/#{model.template}"
      else
        raise "template '#{model.template}' not found"
      end
    end

    def render_list
      helpers.render find_template("templates/lists"), :list => self
    end

    def render_container
      output  = edit_mode? && model.parent ? add_container_link : ''
      output += helpers.render find_template("templates/containers"), :container => self.class.decorate(model)
    end

    def extract(scope, name)
      content = model.contents.find_by_name(name)
      case scope
        when :image_source
          content.text.scan(/<img src="([^\"]+)"/).first.first
        when :text
          content.text
        else
          raise "unknown scope #{scope}"
      end
    end

    def each_child
      unless model.new_record?
        model.children.sorted.each {|child| yield child}
      end
    end

    # --- partials ---

    def render_mercury_region(name, partial)
      content = model.contents.find_or_create_by_name(name)
      helpers.render "templates/snippets/#{partial}", :content => content
    end

    def render_editable_div(name)
      render_mercury_region(name, 'editable_div')
    end

    def render_markupable_div(name)
      render_mercury_region(name, 'markupable_div')
    end

    def render_snippetable_div(name)
      render_mercury_region(name, 'snippetable_div')
    end

    def render_editable_span(name)
      render_mercury_region(name, 'editable_span')
    end

  end
end