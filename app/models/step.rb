class Step < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :trip

  validates :location, presence: true
  validates :date, presence: true
end
