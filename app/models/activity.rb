class Activity < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :reservations
  has_many :likes
  has_many :users, through: :reservations

  has_one_attached :photo

  validates :category, presence: true, inclusion: { in: ["Evénement sportif", "Sport/Fitness", "Concert", "Sortie en ville", "Randonnée", "Gastronomie", "Voyage", "Visite", "Jeux", "Sortie culturelle", "Bénévolat", "Vie quotidienne", "Cinéma", "Plein air", "Atelier"] }
  validates :address, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 20 }
  validates :start_date, presence: true
end
