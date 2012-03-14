# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

page = Roxanne::Page.find_or_create_by_title('home')

if Roxanne::User.count == 0
  admin = Roxanne::User.new
  admin.username = 'admin'
  admin.email    = 'admin@example.com'
  admin.password = 'admin123'
  admin.password_confirmation = 'admin123'
  admin.save!
end