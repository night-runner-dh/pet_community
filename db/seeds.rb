# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: ENV['admintest@yahoo.co.jp']) do |admin|
  admin.password = ENV['123456']
end

User.find_or_create_by!(email: 'test@yahoo.co.jp') do |user|
  user.password = '123456'
  user.name = 'test'
end