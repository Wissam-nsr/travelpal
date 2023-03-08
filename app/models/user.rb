class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  after_validation :set_geocoder_object, if: :will_save_change_to_location?

  has_one_attached :avatar

  has_many :trips, dependent: :destroy
  has_many :steps, through: :trips
  has_many :moments, through: :trips

  validates :username, uniqueness: true, length: { minimum: 5, maximum: 20 }

  def set_geocoder_object
    if location.present?
      self.geocoder_object = Geocoder.search(location).first.data
    elsif latitude.present?
      self.geocoder_object = Geocoder.search([latitude, longitude]).first.data
    end
  end

  # has_many :chatrooms #dependent: :destroy
  # has_many :messages, through: :chatroom, dependent: :destroy
end
