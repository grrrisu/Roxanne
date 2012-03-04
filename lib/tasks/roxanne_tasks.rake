# desc "Explaining what the task does"
# task :roxanne do
#   # Task goes here
# end
namespace :roxanne do

  desc "load seed data"
  task(:seed => :environment) do
    require File.join(Roxanne::Engine.root, '/db/seed.rb')
  end
  
end