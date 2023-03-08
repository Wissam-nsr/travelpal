class Moment < ApplicationRecord
  has_one_attached :photo

  belongs_to :trip

  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :date, presence: true
  validates :photo, attached: true
end
