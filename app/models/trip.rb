class Trip < ApplicationRecord
  has_one_attached :photo

  belongs_to :user
  has_many :steps
  has_many :moments
end
