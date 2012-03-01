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
  end
end
