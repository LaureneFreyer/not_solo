class User < ApplicationRecord
  has_many :activities
  has_many :likes
  has_many :reservations
  has_many :ratings
  has_many :messages
  has_many :chatrooms, through: :messages

  has_one_attached :photo

  validates :nickname, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :birthday, presence: true
  validates :description, presence: true, length: { minimum: 15 }
  validates :interest, presence: true, inclusion: { in: ["Cuisine", "Sport", "Danse", "Voyage", "Art", "Cinéma", "Musique", "Animaux", "Technologie", "Méditation", "Jeux de société", "Jeux vidéo", "Nature", "Photographie", "Bricolage", "Lecture", "Mode", "Sciences", "Sorties", "Automobile", "Jardinage", "Services", "Randonnées", "Découvertes", "Séries", "Nourriture", "Autres"] }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
