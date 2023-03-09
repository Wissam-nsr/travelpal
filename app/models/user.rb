class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  after_validation :after_geocode

  has_one_attached :avatar

  has_many :trips, dependent: :destroy
  has_many :steps, through: :trips
  has_many :moments, through: :trips
  validates :username, uniqueness: true, length: { minimum: 5, maximum: 20 }

  def after_geocode
    if self.location
    results = Geocoder.search([self.latitude, self.longitude])
    self.geocoder_object = results.first.data
  elsif self.latitude
    results = Geocoder.search([self.latitude, self.longitude])
    self.geocoder_object = results.first.data
    self.location = results.first.data.dig('address', 'city_district')
  end
end

def last_trip_moments
  moments = []
  if trips.any?
    trips.last.moments.each do |moment|
      moments << moment
    end
  end
  moments
end

def last_trip_cities
  last_trip_moments.map {|moment| moment.nearest_city }
end

# has_many :chatrooms #dependent: :destroy
# has_many :messages, through: :chatroom, dependent: :destroy

end
