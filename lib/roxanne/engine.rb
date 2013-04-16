require 'mercury-rails'
require 'ancestry'
require 'draper'
require 'sorcery'
require 'haml'
require 'formtastic'

module Roxanne
  class Engine < ::Rails::Engine
    isolate_namespace Roxanne

    paths['app/helpers']

    # Additional application configuration to include precompiled assets.
    initializer :assets, :group => :all do |app|
      app.config.assets.precompile += %w( roxanne_edit.js roxanne_show.js )
    end
  end
end
