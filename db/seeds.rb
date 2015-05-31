# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: "sampleuser@yopmail.com", password: "12345678");
puts user

user2 = User.create(email: "abcd@yopmail.com", password: "12345678");
puts user2
