# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
r1 = Role.new
r1.name = "admin"
r1.save

r2 = Role.new
r2.name = "institute"
r2.save 

user = User.new
user.name_institute = "SisWGCIEP"
user.email = "admin@admin.com"
user.phone = "99999999"
user.role_id = 1
user.name_responsible = "Admin"
user.neighborhood = "Todos"
user.password = "12345678"
user.save