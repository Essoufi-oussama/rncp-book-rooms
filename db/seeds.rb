# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

unsplash_url = 'https://source.unsplash.com/random/?hotel-bedroom'
Hotel.destroy_all
Room.destroy_all

20.times do
  hotel = Hotel.create(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
  )
  hotel.save
  # Create 4 rooms for each hotel
  rand(1..3).times do
    image_url = URI.open(unsplash_url).base_uri.to_s
    image_data = URI.open(image_url).read

    room = Room.new(
      capacity: rand(1..3),
      price_per_night: rand(50..200),
      hotel: hotel
    )
    room.photo.attach(io: StringIO.new(image_data), filename: "#{hotel.name.parameterize}-#{rand(1..9999)}.jpg", content_type: 'image/jpeg')
    room.save

  end
end
