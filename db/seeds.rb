# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: 'admintest@yahoo.co.jp') do |admin|
  admin.password = '123456'
end

User.find_or_create_by!(email: 'test@yahoo.co.jp') do |user|
  user.password = '123456'
  user.name = 'test'
end

User.find_or_create_by!(email: 'test2@yahoo.co.jp') do |user|
  user.password = '123456'
  user.name = 'test2'
end

User.find_or_create_by!(email: 'test3@yahoo.co.jp') do |user|
  user.password = '123456'
  user.name = 'test3'
end

user = User.find_by(name: "test")
Post.find_or_create_by!(title: "test") do |post|
  post.image.attach(io: File.open("#{Rails.root}/app/assets/images/pet_sample1.jpg"), filename: "pet_sample1.jpg")
  post.body = "投稿テスト用データです。"
  post.user = user
end

user = User.find_by(name: "test2")
Post.find_or_create_by!(title: "投稿テスト2") do |post|
  post.image.attach(io: File.open("#{Rails.root}/app/assets/images/pet_sample2.jpg"), filename: "pet_sample2.jpg")
  post.body = "投稿データ2です。"
  post.user = user
end