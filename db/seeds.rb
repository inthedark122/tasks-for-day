# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User
user = User.create({ email: 'padshyangel@mail.ru', password: 'test1234'})

# Tasks
Task.create({ name: 'First task', description: 'My first task', user: user})
Task.create({ name: 'Without user', description: 'Second task'})