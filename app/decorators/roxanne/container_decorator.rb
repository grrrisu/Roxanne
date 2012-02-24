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

    def add_container_list_link

    end

    def render_list
      if helpers.session[:edit]
        helpers.render "contents/list_edit", :list => self
      else
        helpers.render "contents/list", :list => self
      end
    end

    def render_list_old
      output = ''
      model.children.sorted.each do |child|
        output += self.class.decorate(child).render
      end
      output += add_container_link
      helpers.content_tag('div', output, {:class => '.container_list'}, false)
    end

    def render_container
      if helpers.session[:edit]
        output =  add_container_link
        if helpers.controller.template_exists? "#{model.template}_edit", ["templates"], true
          output += render_template "templates/#{model.template}_edit"
        else
          output += render_template "templates/#{model.template}"
        end
      else
        render_template "templates/#{model.template}"
      end
    end

    def render_template(template)
      helpers.render template, :container => self.class.decorate(model)
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