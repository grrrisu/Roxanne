module Roxanne
  module ApplicationHelper
    def title text
      content_for(:title, text)
    end

    def meta
      content_for(:meta, yield)
    end

    def render_admin_panel
      if current_user && params[:requested_uri].blank?
        render 'roxanne/admin/panel'
      end
    end
    
    def render_flash
      render 'roxanne/admin/flash'
    end

    def request_uri
      uri = request.fullpath[1..-1]
      uri.empty? ? nil : uri
    end
    
    def find_templates(template_path, partials = true)
      view_paths.paths.map do |path|
        if File.exists?("#{path}/#{template_path}")
          Dir.glob("#{path}/#{template_path}/*.html.*")
        end
      end.flatten.compact.delete_if do |path|
        path.include?('_edit.html')
      end.map do |path|
        if partials
          path.match(/\/_([^\/]+)\.html\.[^.]+$/).try(:[],1)
        else
          path.match(/\/([^_][^\/]+)\.html\.[^.]+$/).try(:[],1)
        end
      end.compact
    end
    
  end
end
