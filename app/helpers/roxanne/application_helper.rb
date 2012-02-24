module Roxanne
  module ApplicationHelper
    def title text
      content_for(:title, text)
    end

    def meta
      content_for(:meta, yield)
    end

    def show_admin_panel
      current_user && params[:requested_uri].blank?
    end

    def request_uri
      uri = request.fullpath[1..-1]
      uri.empty? ? nil : uri
    end
  end
end
