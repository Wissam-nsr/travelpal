class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :avatar

  has_many :trips, dependent: :destroy
  validates :username, uniqueness: true, length: { minimum: 5, maximum: 20 }
end
