require 'json'
require 'open-uri'

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


ngo_photo_array = ['http://res.cloudinary.com/dsmei8zni/image/upload/v1510750337/1.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510750336/2.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510750320/3.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510750303/4.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510846456/5.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510846441/6.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510846432/7.jpg', 'http://res.cloudinary.com/dsmei8zni/image/upload/v1510846278/8.jpg']


uri = URI.parse("https://projects.propublica.org/nonprofits/api/v2/search.json?q=propublica")
data = JSON.parse(uri.read)

puts "Seeding Ngos..."
status_list = ['done', 'scheduled', 'failed']
orgs = data["organizations"]
(0..20).each do |i|
  ngo_hash = orgs[i]
  ngo = Ngo.create!({
    name: ngo_hash["name"],
    address: ngo_hash["name"] +" "+ ngo_hash["city"],
    description: Faker::Lorem.paragraph(2),
    photo: ngo_photo_array.shuffle.sample
  })

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
puts "finished!"


