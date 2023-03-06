class Chatroom < ApplicationRecord
  belongs_to :user_one, foreign_key: "user_id"
  belongs_to :user_two, foreign_key: "user_id"
  has_many :messages, dependent: :destroy
end
