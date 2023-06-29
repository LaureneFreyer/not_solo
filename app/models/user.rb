class User < ApplicationRecord
  serialize :interest, Array

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :messages,  dependent: :destroy
  has_many :chatrooms, through: :messages

  has_one_attached :photo
  validate :photo_size_validation


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

  private

  def photo_size_validation
    errors[:photo] << "should be less than 1MB" if photo.attached? && photo.blob.byte_size > 1.megabyte
  end
end
