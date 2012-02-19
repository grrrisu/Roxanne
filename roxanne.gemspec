$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "roxanne/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "roxanne"
  s.version     = Roxanne::VERSION
  s.authors     = ["Alessandro Di Maria"]
  s.email       = ["adm@m42.ch"]
  #s.homepage    = "TODO"
  s.summary     = "Simple CMS based on Mercury"
  s.description = "Simple CMS based on Mercury"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.1"
  s.add_dependency 'mercury-rails', "~> 0.3.1"
  s.add_dependency 'ancestry'
  s.add_dependency 'haml'
  s.add_dependency 'draper'
  s.add_dependency 'formtastic'
  s.add_dependency 'sorcery'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.8.1"
  s.add_development_dependency 'cucumber-rails'
  s.add_development_dependency 'spork-rails'
  s.add_development_dependency 'factory_girl_rails'
end
