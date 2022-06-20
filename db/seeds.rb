# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Creating Users...'
u1 = User.where(email: 'marcelo.mita.poli@gmail.com').first
u1 ||= User.create!(name: 'Marcelo Mita', email: 'marcelo.mita.poli@gmail.com', password: 'password')

u2 = User.where(email: 'test@test.com').first
u2 ||= User.create!(name: 'Test Test', email: 'test@test.com', password: 'password')

puts 'Creating Restaurants...'
r1 = Restaurant.find_or_create_by(name: 'Restaurant 1')
r2 = Restaurant.find_or_create_by(name: 'Restaurant 2')
r3 = Restaurant.find_or_create_by(name: 'Restaurant 3')
r4 = Restaurant.find_or_create_by(name: 'Restaurant 4')
r5 = Restaurant.find_or_create_by(name: 'Restaurant 5')
r6 = Restaurant.find_or_create_by(name: 'Restaurant 6')
r7 = Restaurant.find_or_create_by(name: 'Restaurant 7')

u1.restaurants = [r1, r2, r3, r7]
u2.restaurants = [r4, r5, r6, r7]

m1 = Menu.find_or_create_by()
