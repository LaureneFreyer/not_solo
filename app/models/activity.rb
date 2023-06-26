class Activity < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :likes

  has_one_attached :photo

  validates :category, presence: true, inclusion: { in: ["Match de sport", "Activité physique", "Concert", "Sortie en ville", "Randonnée", "Activité culinaire", "Voyage", "Visite", "Jeux", "Sortie culturelle", "Activité artistique", "Vie quotidienne", "Cinéma", "Restaurant"] }
  validates :address, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 20 }
  validates :start_date, presence: true
end
