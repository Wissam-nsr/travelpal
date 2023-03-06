class Moment < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :photo

  belongs_to :trip

  validates :location, presence: true
  validates :date, presence: true
  validates :photo, attached: true
end
