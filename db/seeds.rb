require "open-uri"

def random_spot(origin_coordinates, km_distance)
  origin_latitude = origin_coordinates[0]
  origin_longitude = origin_coordinates[1]

  offset = km_distance * 0.01

  new_lng = rand(origin_longitude - offset..origin_longitude + offset).round(6)
  new_lat = rand(origin_latitude - offset..origin_latitude + offset).round(6)

  [new_lat, new_lng]
end

# RESET DATA_BASE
Message.destroy_all
Chatroom.destroy_all
Moment.destroy_all
Step.destroy_all
Trip.destroy_all
User.destroy_all

# USERS
puts "Creating a demo user and 10 random Users"
puts "..."

# Demo User:
demo_user = User.new
demo_user.email = "stephan@demo.com"
demo_user.password = "123456"
demo_user.username = "Stephan_Supertramp"
demo_user.description = "Traveling through Europe for a year. Looking fro new friends and adventures"
demo_user.avatar.attach(io: URI.open("https://images.unsplash.com/photo-1547699326-3d895d9acd30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=200&q=80"), filename: "nes.png", content_type: "image/png")
demo_user.latitude = "48.8590453"
demo_user.longitude = "2.2933084"
demo_user.save!

USER_NAMES = ["Agathe", "Hugo_en", "Laura", "Matthew", "Roberto", "Nicolas", "Alexander", "Paul_from_sweden", "Nadia", "Sydney"]

# 10 other users:
BIOS = [
  "Wonder less, Wander more.",
  "Strong believer in the fact that traveling enriches your soul and opens your mind.",
  "I haven't been everywhere, but it's definitely on my list.",
  "One life. One world. Explore it as much as you can.",
  "Suffering from Wanderlust.",
  "I have Wanderlust: a strong desire to travel.",
  "Travel is my therapy.",
  "Travel! Money returns with time, but time doesn't.",
  "It's not necessary that those who wander are lost.",
  "Leave only footprints and take away only memories.",
  "Life is too short to be lived in one place.",
  "Keep calm and travel on.",
  "I've got 99 problems. But I am on vacation and I am ignoring them all!",
  "If traveling was free, BYE!",
  "In need of vitamin SEA.",
  "I'm in love with places I've never been to.",
  "Buy the ticket, take the ride.",
  "Making memories all over the world.",
  "I need a vacation for so long, I forget all my passwords!",
  "It's bad manners to let vacation wait!",
  "A change of latitude helps my attitude.",
  "I've got a bad case of wanderlust.",
  "Finding paradise wherever I go.",
  "I have an insane calling to be where I'm not.",
  "Happiness is planning a trip to somewhere new."
]

AVATARS_URL = [
  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1566492031773-4f4e44671857?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1607746882042-944635dfe10e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGF2YXRhcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60"
]

i = 0
10.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = "123456"
  user.username = USER_NAMES[i]
  user.description = BIOS.sample
  avatar = AVATARS_URL.sample
  user.avatar.attach(io: URI.open(avatar), filename: "nes.png", content_type: "image/png")
  AVATARS_URL.delete(avatar)
  user.save
  i += 1
end

travelers = User.all.drop(1)

travelers.first(4).each do |traveler|
  spot = random_spot([demo_user.latitude, demo_user.longitude], 10)
  traveler.latitude = spot[0]
  traveler.longitude = spot[1]
  traveler.save
end

travelers = travelers.drop(4)

travelers.first(2).each do |traveler|
  spot = random_spot([demo_user.latitude, demo_user.longitude], 50)
  traveler.latitude = spot[0]
  traveler.longitude = spot[1]
  traveler.save
end

travelers = travelers.drop(2)

travelers.each do |traveler|
  spot = random_spot([demo_user.latitude, demo_user.longitude], 100)
  traveler.latitude = spot[0]
  traveler.longitude = spot[1]
  traveler.save
end

puts "Done ! (#{User.count} Users)"
puts "Demo user: stephan@demo.com, pwd: 123456"

# TRIPS
puts "Creating 13 Trips: 1 for each user  & 2 former trips for the demo user"
puts "..."

#Two previous trips for the demo user

# First trip in Ireland
trip = Trip.new
trip.user = User.all.order(:id)[1]
trip.name = "Ireland 2022"
trip.description = "Campervan roadtrip through Ireland"
trip.photo.attach(io: URI.open("https://images.unsplash.com/photo-1630784033384-a912e9b82090?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fGlyZWxhbmR8ZW58MHx8MHx8&auto=format&fit=crop&w=200&q=60"), filename: "nes.png", content_type: "image/png")
trip.save

locations=["Dublin", "Galway", "Limerik", "Killarney National Park", "Cork"]
date = Date.new(2022,04,01)

locations.each do |location|
  step = Step.new
  step.trip = Trip.all.last
  step.location = location
  step.name = location
  step.description = Faker::Lorem.sentence
  step.date = date
  step.save
  date += 4
end

Trip.all.last.steps.each do |step|
  rand(2..4).times do
    moment = Moment.new
    moment.trip = step.trip
    moment.description = Faker::Lorem.sentence
    location = random_spot([step.latitude, step.longitude], 10)
    moment.latitude = location[0]
    moment.longitude = location[1]
    moment.photo.attach(io: URI.open("https://source.unsplash.com/random/?ireland-tourism"), filename: "nes.png", content_type: "image/png")
    moment.date = Faker::Date.between(from: step.date, to: step.date + 3)
    moment.save
  end
end

# Second trip in Iceland
trip = Trip.new
trip.user = User.all.order(:id)[1]
trip.name = "Iceland 2021"
trip.description = "South of Iceland during summer"
trip.photo.attach(io: URI.open("https://images.unsplash.com/photo-1548191656-893904d26e3e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGljZWxhbmQlMjBtYXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"), filename: "nes.png", content_type: "image/png")
trip.save

locations=["Reykjavík", "Reynisfjara Beach", "Skaftafell", "Diamond Beach"]
date = Date.new(2022,04,01)
i = 0

locations.each do |location|
  step = Step.new
  step.trip = Trip.all.last
  step.location = location
  step.name = location
  step.description = Faker::Lorem.sentence
  step.date = date
  step.save
  date += 2
end

Trip.all.last.steps.each do |step|
  rand(2..4).times do
    moment = Moment.new
    moment.trip = step.trip
    moment.description = Faker::Lorem.sentence
    location = random_spot([step.latitude, step.longitude], 10)
    moment.latitude = location[0]
    moment.longitude = location[1]
    moment.photo.attach(io: URI.open("https://source.unsplash.com/random/?iceland-tourism"), filename: "nes.png", content_type: "image/png")
    moment.date = Faker::Date.between(from: step.date, to: step.date + 1)
    moment.save
  end
end

#One current trip for each users
TRIPS = [
  "Europe by train",
  "France discovery",
  "Western Europe",
  "European capitals"
]

TRIP_PHOTOS = [
  "https://images.unsplash.com/photo-1670002577810-25df64be0161?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGV1cm9wZSUyMGJ5JTIwdHJhaW58ZW58MHx8MHx8&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZnJhbmNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1589262804704-c5aa9e6def89?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZXVyb3BlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=200&q=60",
  "https://images.unsplash.com/photo-1454386608169-1c3b4edc1df8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=200&q=80",
]

DESCRIPTIONS = [
  "Beautiful views, comfortable train cars, the bustle of busy platforms, and the thrill of a new adventure: Europe by train!",
  "Check list: eat a baguette and a croissant, taste the wine, see the Eiffel Tower, experience the french food!",
  "Road trip to western Europe, wanting to discover Portugal, France, Spain, UK and Italy",
  "Culture discovery in europeans capital cities"
]

11.times do
  trip = Trip.new
  name = TRIPS.sample
  index = TRIPS.index(name)
  trip.name = name
  trip.description = DESCRIPTIONS[index]
  trip.photo.attach(io: URI.open(TRIP_PHOTOS[index]), filename: "nes.png", content_type: "image/png")
  trip.user = User.all.first
  trip.save
end

trips = Trip.all.order(:id).map { |trip| trip }

trips = trips.drop(2)
i = 0

trips.each do |trip|
  trip.user = User.all[i]
  trip.save
  i += 1
end

puts "Done ! (#{Trip.count} Trips)"

# STEPS
puts "Creating between 2 and 5 Steps per trips"
puts "..."

STEPS = {
  "Europe by train" => [
    "Bucharest",
    "Budapest",
    "Vienna",
    "Zagreb",
    "Ljubljana",
    "Florence",
    "Milan",
    "Prague",
    "Munich",
    "Berlin",
    "Amsterdam",
    "Lille",
    "Paris",
    "Bordeaux",
    "Barcelona",
    "Madrid",
    "Lisbon",
    "London"
  ],
  "France discovery" => [
    "Marseille",
    "Toulouse",
    "Bordeaux",
    "Nantes",
    "Rennes",
    "Tours",
    "Orléans",
    "Lyon",
    "Strasbourg",
    "Reims",
    "Lille"
  ],
  "Western Europe" => [
    "Florence",
    "Milan",
    "Munich",
    "Berlin",
    "Amsterdam",
    "London",
    "Paris",
    "Bordeaux",
    "Barcelona",
    "Valencia",
    "Madrid",
    "Seville",
    "Lisbon",
    "Porto"
  ],
  "European capitals" => [
    "Bucharest",
    "Budapest",
    "Vienna",
    "Zagreb",
    "Ljubljana",
    "Rome",
    "Prague",
    "Berlin",
    "Amsterdam",
    "London",
    "Paris",
    "Barcelona",
    "Madrid",
    "Lisbon"
  ]
  }

trips.each do |trip|
  step_list = STEPS[trip.name].map { |step| step }
  trip_date = Faker::Date.between(from: 60.days.ago, to: Date.today)

  rand(2..5).times do
    step = Step.new
    step.trip = trip
    step.location = step_list.sample
    step.name = step.location
    index = STEPS[trip.name].index(step.location)
    step.description = Faker::Lorem.sentence
    step.date = trip_date + index
    step_list.delete(step.location)
    step.save
  end
end

puts "Done ! (#{Step.count} Steps)"

# MOMENTS
puts "Creating between 1 and 3 Moments per Steps"
puts "..."

QUERIES = [
  "europe-tourism",
  "france-tourism",
  "europe-tourism",
  "europe-capitals"
]

step_list = Step.all.map { |step| step }
step_list.reject!{|step| step.trip == Trip.all.order(:id)[0] || step.trip == Trip.all.order(:id)[1]}


step_list.each_with_index do |step, index|

  rand(1..3).times do
    moment = Moment.new
    trip_index = TRIPS.index(step.trip.name)
    query = QUERIES[trip_index]
    moment.trip = step.trip
    moment.description = Faker::Lorem.sentence
    location = random_spot([step.latitude, step.longitude], 10)
    moment.latitude = location[0]
    moment.longitude = location[1]
    moment.photo.attach(io: URI.open("https://source.unsplash.com/random/?#{query}"), filename: "nes.png", content_type: "image/png")
    moment.date = Faker::Date.between(from: step.date - 2, to: step.date + 2)
    moment.save
  end
  puts "#{index + 1} / #{step_list.count} steps"
  puts "..."
end

puts "Done ! (#{Moment.count} Moments)"

# CHATROOMS
puts "Creating between 2 and 3 Chatrooms per user"
puts "..."

User.all.each_with_index do |user, index|
  rand(2..3).times do
    chatroom = Chatroom.new
    chatroom.user_one = user
    chatroom.user_two = User.where.not(username: user.username).sample
    chatroom.save
  end
  puts "#{index + 1} / #{User.count} users"
  puts "..."
end

puts "Done ! (#{Chatroom.count} Chatrooms)"

# MESSAGES
puts "Creating between 3 and 6 Messages per user"
puts "..."

Chatroom.all.each_with_index do |chatroom, index|
  rand(3..6).times do
    message = Message.new
    message.content = BIOS.sample
    message.user = [chatroom.user_one, chatroom.user_two].sample
    message.chatroom = chatroom
    message.save
  end
  puts "#{index + 1} / #{Chatroom.count} chatrooms"
  puts "..."
end

puts "Done ! (#{Message.count} Messages)"

puts "------ SEED DONE 🚀 ------"
