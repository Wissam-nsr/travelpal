class Trip < ApplicationRecord
  has_one_attached :photo

  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :moments, dependent: :destroy

  validates :name, length: { minimum: 5 }
  validates :photo, attached: true
end
