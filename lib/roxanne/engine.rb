require 'mercury-rails'
require 'ancestry'
require 'draper'
require 'sorcery'
require 'haml'
require 'formtastic'

module Roxanne
  class Engine < ::Rails::Engine
    isolate_namespace Roxanne
  end
end