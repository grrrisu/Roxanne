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

    def template_selection
      child = Container.new :name => name
      if model.instance_of? ContainerList
        locals = {:parent => model, :sibling => nil}
      else
        locals = {:parent => model.parent, :sibling => model}
      end
      helpers.render 'containers/template_selection', locals.merge(:container => child)
    end

    def add_container_link
      if helpers.current_user
        if model.instance_of? ContainerList
          data = {:parent => model.id, :name => model.name}
        else
          data = {:sibling => model.id, :name => model.name}
        end
        helpers.content_tag 'a', '',
                 :id => "before_#{model.id}",
                 :href => "#", :onclick => "return false;", :class => "add_container",
                 :data => data
      else
        ''
      end
    end
    
    def find_template(directory, template)
      if helpers.session[:edit] && helpers.controller.template_exists?("#{template}_edit", [directory], true)
        "#{directory}/#{template}_edit"
      else
        "#{directory}/#{template}"
      end
    end

    def render_list(template)
      helpers.render find_template("contents", template), :list => self
    end
    
    def render_container
      output  = helpers.session[:edit] ? add_container_link : ''
      output += helpers.render find_template("templates", model.template), :container => self.class.decorate(model)
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

    # --- partials ---

    def render_mercury_region(name, partial)
      content = model.contents.find_or_create_by_name(name)
      helpers.render "contents/#{partial}", :content => content
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