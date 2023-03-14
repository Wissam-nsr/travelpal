class Moment < ApplicationRecord
  has_one_attached :photo

  belongs_to :trip
  has_one :user, through: :trip

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :date, presence: true
  validates :photo, attached: true

  after_validation :after_geocode

  def after_geocode
      results = Geocoder.search([self.latitude, self.longitude])
      self.geocoder_object = results.first.data
  end

  def nearest_city
    if self.geocoder_object["address"]["municipality"].present?
      self.geocoder_object["address"]["municipality"]
    elsif self.geocoder_object["address"]["city_district"].present?
      self.geocoder_object["address"]["city_district"]
    else
      "somehwere in Australia"
    end
  end

end
