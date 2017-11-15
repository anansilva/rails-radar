# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creating Seeds"

# Destroy previous data
puts "Destroying current database in 5 seconds, press CTRL + C to cancel"
sleep(5)
Donation.destroy_all
NgoType.destroy_all
Ngo.destroy_all
Type.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(Ngo.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(NgoType.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Donation.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Type.table_name)

# Create 1 Test user
User.create( first_name: "Test", last_name: "User", email: "example@example.com", password: "secret")


# Seeding Types
puts "Seeding types..."
type_list = ['Food', 'Clothes', 'Electronics', 'Furniture', 'Bicycles', 'Books', 'Other']
type_list.each do |t|
  unless Type.find_by(name: t)
    Type.create(name: t)
  end
end

# Seeding NGOs

puts "Seeding Ngos..."
status_list = ['done', 'scheduled', 'failed']

10.times do
  ngo = Ngo.create(
    name: Faker::Company.name,
    address: Faker::Address.street_name,
    description: Faker::Lorem.paragraph(2),
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
      user_id: User.first.id,
      ngo_id: ngo.id,
      items: "This is a list of items",
      schedule: Date.new,
      comments: "This is a comment",
      address: ngo.address,
      type_id: ngo.types.sample.id,
      status: status_list.sample
      )
  end

  ngo.reload
end
