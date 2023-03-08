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
demo_user.description = "Backpacking alone in the wild Australia after a trip in Japan. Looking fro new friends and adventures"
demo_user.location = "380 Roma St, Brisbane City QLD 4000, Australie"
demo_user.avatar.attach(io: URI.open("https://img.freepik.com/photos-gratuite/touriste-masculin-serieux-porte-sac-dos-equipement-necessaire-pour-voyageur-aime-voyager-longues-distances-prefere-vacances-actives-boit-du-cafe_273609-33658.jpg?w=740&t=st=1678187049~exp=1678187649~hmac=42bc387501e174ec55f1ab9bff6db346b7cfb4da9f7ba647a06522d70cf613ba"), filename: "nes.png", content_type: "image/png")
demo_user.save

p demo_user.latitude
p demo_user.longitude

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

10.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = "123456"
  user.username = Faker::Internet.username(specifier: 5...20)
  user.description = BIOS.sample
  user.avatar.attach(io: URI.open(AVATARS_URL.sample), filename: "nes.png", content_type: "image/png")
  user.save
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
puts "Creating 15 Trips"
puts "..."

TRIPS = [
  "Great Ocean Road",
  "West Coast",
  "Est Coast",
  "Northen Territories",
  "Outback"
]

TRIP_PHOTOS = [
  "https://images.unsplash.com/photo-1519709063170-124e1d4a8e24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODd8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1596037560218-72a6812a6574?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8ODh8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1560424730-ec1c186a7573?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzF8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1592930506084-71a406f242a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTJ8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1446768500601-ac47e5ec3719?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjl8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=600",
  "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjF8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1553076446-829d6dba2f0b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1532339142463-fd0a8979791a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8dHJpcHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1573097637683-58e6462d2902?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHRyaXB8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dHJpcHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"
]

DESCRIPTIONS = [
  "One of the country's most famous road trips stretches along its southern coast from Torquay to Allansford in Victoria.",
  "It's a wind-the-windows-down kind of road trip that embraces Australia's coastal beauty and laid-back vibes. Plus, it passes what many would argue is the country's most iconic road trip pit stop: the Big Banana in Coffs Harbour.",
  "Just under 1200 kilometres, this west coast drive takes you from Perth to Exmouth along WA's stunning Coral Coast via Cervantes, Geraldton, Monkey Mia and Carnarvon.",
  "Take in the Top End with this one-day trip that runs through Litchfield National Park. From the city you'll head bush, tracing your way through Katherine and Kakadu before you meet Litchfield; a strip overflowing with waterfalls (excuse the pun), swimming holes, and incredible rock formations.",
  "The central Australian outback is a place of transformation. Ancient ochre landscapes, dynamic cultures and bright, starry skies create an energy unique to Australia's red heart - difficult to put into words, but impossible not to feel."
]

15.times do
  trip = Trip.new
  trip.name = TRIPS.sample
  trip.description = DESCRIPTIONS.sample
  trip.photo.attach(io: URI.open(TRIP_PHOTOS.sample), filename: "nes.png", content_type: "image/png")
  trip.user = User.all.sample
  trip.save
end

Trip.all.first(5).each do |trip|
  trip.ended = true
  trip.save
end

puts "Done ! (#{Trip.count} Trips)"

# STEPS
puts "Creating between 3 and 6 Steps per trips"
puts "..."

STEPS = {
  "Great Ocean Road" => [
    "Adelaide",
    "Barossa Valley",
    "Cape Jervis",
    "Victor Harbor",
    "Robe",
    "Mount Gambier",
    "Port Fairy",
    "Port Campbell National Park",
    "Cape Otway",
    "Torquay Victoria",
    "Geelong",
    "Melbourne"
  ],
  "West Coast" => [
    "Broome WA",
    "Port Headland",
    "Karratha",
    "Exmouth WA" ,
    "Coral Bay",
    "Carnarvon" ,
    "Monkey Mia" ,
    "Kalbarri" ,
    "Geraldton",
    "Jurien Bay",
    "Perth"
  ],
  "Est Coast" => [
    "Cape Tribulation QLD",
    "Cairns",
    "Airlie Beach",
    "Rockhampton QLD",
    "Fraser Island",
    "Noosa",
    "Brisbane",
    "Gold Coast",
    "Byron Bay",
    "Coffs Harbour",
    "Port Macquarie",
    "Hunter Valley",
    "Sydney"
  ],
  "Northen Territories" => [
    "Darwin",
    "Jabiru",
    "Ubirr",
    "Cooinda",
    "Jim Jim Falls",
    "Gunlom",
    "Pine Creek NT",
    "Katherine",
    "Nitmiluk National Park"
  ],
  "Outback" => [
    "Darwin",
    "Kakadu National Park",
    "Nitmiluk National Park",
    "Alice Springs",
    "Uluru-Kata Tjuta National Park",
    "Coober Pedy",
    "Flinders Ranges",
    "Barossa Valley",
    "Victor Harbor",
    "Adelaide"
  ] }

Trip.all.each do |trip|
  step_list = STEPS[trip.name].map { |step| step }
  rand(3..6).times do
    step = Step.new
    step.trip = trip
    step.location = step_list.sample
    step.name = step.location
    step_list.delete(step.location)
    step.description = Faker::Lorem.sentence
    step.date = Faker::Date.between(from: 60.days.ago, to: Date.today)
    step.save
  end
end

puts "Done ! (#{Step.count} Steps)"

# MOMENTS
puts "Creating between 2 and 5 Moments per Steps"
puts "..."

Step.all.each_with_index do |step, index|
  rand(2..5).times do
    moment = Moment.new
    moment.trip = step.trip
    moment.description = Faker::Lorem.sentence
    location = random_spot([step.latitude, step.longitude], 20)
    moment.latitude = location[0]
    moment.longitude = location[1]
    moment.photo.attach(io: URI.open("https://source.unsplash.com/random/?australian-landscape"), filename: "nes.png", content_type: "image/png")
    moment.date = step.date = Faker::Date.between(from: step.date - 2, to: step.date + 2)
    moment.save
  end
  puts "#{index + 1} / #{Step.count} steps"
  puts "..."
end

puts "Done ! (#{Moment.count} Moments)"

puts "------ SEED DONE 🚀 ------"
