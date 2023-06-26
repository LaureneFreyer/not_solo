class Reservation < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  has_many :chatrooms
  has_many :ratings
end
