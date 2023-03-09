class Moment < ApplicationRecord
  has_one_attached :photo

  belongs_to :trip

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :date, presence: true
  validates :photo, attached: true
  after_validation :set_geocoder_object, if: :will_save_change_to_latitude?

end

def set_geocoder_object
  if latitude.present?
    self.geocoder_object = Geocoder.search([latitude, longitude]).first.data
  end
end
