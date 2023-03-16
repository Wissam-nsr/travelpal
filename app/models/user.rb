class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_location?
  # after_validation :after_geocode

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :after_geocode
  # after_validation :geocode if :will_save_change_to_address?
  # after_validation :reverse_geocode, :after_geocode

  has_one_attached :avatar

  has_many :trips, dependent: :destroy
  has_many :steps, through: :trips
  has_many :moments, through: :trips
  has_many :chatrooms
  has_many :messages, through: :chatroom
  validates :username, uniqueness: true, length: { minimum: 5, maximum: 20 }

  def after_geocode
    if self.address
      results = Geocoder.search([self.latitude, self.longitude])
      self.geocoder_object = results.first.data
    elsif self.latitude
      results = Geocoder.search([self.latitude, self.longitude])
      self.geocoder_object = results.first.data
      self.address = results.first.data.dig('address', 'city_district')
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

  def chatroom_with(user)
    Chatroom.find_by(user_one: [self, user], user_two: [self, user])
  end

  def chatrooms
    Chatroom.where(user_one:User.first).or(Chatroom.where(user_two:User.first))
  end

end
