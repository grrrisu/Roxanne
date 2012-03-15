module Roxanne
  module ContainersHelper

    def find_templates(template_path)
      view_paths.paths.map do |path|
        if File.exists?("#{path}/#{template_path}")
          Dir.glob("#{path}/#{template_path}/*.html.*")
        end
      end.flatten.compact.delete_if do |path|
        path.include?('_edit.html')
      end.map do |path|
        path.match(/\/_([^\/]+)\.html\.[^.]+$/)[1]
      end
    end

    def containers_collection
      find_templates('templates/containers')
    end

    def lists_collection
      find_templates('templates/lists')
    end

  end
end