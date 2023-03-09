class Moment < ApplicationRecord
  has_one_attached :photo

  belongs_to :trip

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :date, presence: true
  validates :photo, attached: true

  after_validation :geocode

  def geocode
    results = Geocoder.search([self.latitude, self.longitude])
    self.geocoder_object = results.first.data
  end

end
