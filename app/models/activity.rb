class Activity < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :reservations
  has_many :likes
  has_many :users, through: :reservations
  has_one :chatroom

  has_one_attached :photo
  validate :photo_size_validation


  CATEGORIES = ["Evénement sportif", "Sport/Fitness", "Concert", "Sortie en ville", "Randonnée", "Gastronomie", "Voyage", "Visite", "Jeux", "Sortie culturelle", "Bénévolat", "Vie quotidienne", "Cinéma", "Plein air", "Atelier"]
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :address, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 20 }
  validates :start_date, presence: true


  CATEGORY_ICONS =
  {
    "Evénement sportif" => "fa-solid fa-medal",
    "Sport/Fitness" => "fa-solid fa-baseball-bat-ball",
    "Concert" => "fa-solid fa-music",
    "Sortie en ville" => "fa-solid fa-city",
    "Randonnée" => "fa-solid fa-person-hiking",
    "Gastronomie" => "fa-solid fa-utensils",
    "Voyage" => "fa-solid fa-plane",
    "Visite" => "fa-solid fa-camera",
    "Jeux" => "fa-solid fa-dice",
    "Sortie culturelle" => "fa-solid fa-masks-theater",
    "Bénévolat" => "fa-solid fa-hand-holding-heart",
    "Vie quotidienne" => "fa-solid fa-cart-shopping",
    "Cinéma" => "fa-solid fa-film",
    "Plein air" => "fa-solid fa-mountain-sun",
    "Atelier" => "fa-solid fa-palette",
  }

CATEGORY_IMAGES = {
  "Evénement sportif" => "event-sportif.jpg",
  "Sport/Fitness" => "sport-fitness.jpg",
  "Concert" => "concert.jpg",
  "Sortie en ville" => "sortie.jpg",
  "Randonnée" => "randonnée.jpg",
  "Gastronomie" => "Gastronomy.jpg",
  "Voyage" => "voyage.jpg",
  "Visite" => "sport-fitness.jpg",
  "Jeux" => "jeux.jpg",
  "Sortie culturelle" => "sortie-culturelle.jpg",
  "Bénévolat" => "sport-fitness.jpg",
  "Vie quotidienne" => "vie quotidienne.jpg",
  "Cinéma" => "cinema.jpg",
  "Plein air" => "randonnée.jpg",
  "Atelier" => "Atelier.jpg",
}

  private

  def photo_size_validation
    errors[:photo] << "should be less than 1MB" if photo.attached? && photo.blob.byte_size > 1.megabyte
  end
end
