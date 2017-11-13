# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating Seeds"

# Create 1 Test user
User.create( first_name: "Test", last_name: "User", email: "example@example.com", password: "secret")


# Seeding Types
Type.destroy_all

type_list = ['Food', 'Clothes', 'Electronics', 'Furniture', 'Bycicles', 'Books', 'Other']
type_list.each do |t|
  unless Type.find_by(name: t)
    Type.create(name: t)
  end
end

# Seeding NGOs

10.times do
  ngo = Ngo.create(
    name: Faker::Company.name,
    address: Faker::Address.street_name,
    lat: Faker::Address.latitude,
    lng: Faker::Address.longitude
    )

  # Seed NGO Types
  first = Type.first.id
  last = Type.last.id

  rand(1..3).times do
    ngo.ngo_types.create(type_id: (rand(first..last).to_i))
  end

  # Create donations

  rand(0..2).times do
    Donation.create(
      user_id: 1,
      ngo_id: ngo.id,
      items: "This is a list of items",
      schedule: Date.new,
      comments: "This is a comment",
      address: ngo.address,
      type_id: ngo.types.sample.id
      )
  end

  ngo.reload
end
