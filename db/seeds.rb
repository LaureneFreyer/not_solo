# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require_relative 'seeds_data/cities' # Chargement de la liste des villes

# db/seeds.rb
User.destroy_all
Activity.destroy_all

ACTIVITY_CATEGORIES = [
  "Match de sport", "Activité physique", "Concert", "Sortie en ville",
  "Randonnée", "Activité culinaire", "Voyage", "Visite", "Jeux",
  "Sortie culturelle", "Activité artistique", "Vie quotidienne", "Cinéma",
  "Restaurant"
]

USER_INTERESTS = [
  "Cuisine", "Sport", "Danse", "Voyage", "Art", "Cinéma", "Musique", "Animaux",
  "Technologie", "Méditation", "Jeux de société", "Jeux vidéo", "Nature",
  "Photographie", "Bricolage", "Lecture", "Mode", "Sciences", "Sorties",
  "Automobile", "Jardinage", "Services", "Randonnées", "Découvertes",
  "Séries", "Nourriture", "Autres"
]

# Méthode pour générer des coordonnées aléatoires en France

# def seed pour l'admin :
User.create!(
  email: "lolodu35@gmail.com",
  password: "123456",
  nickname: "LoloDu35",
  first_name: "Lauréne",
  last_name: "Freyer",
  address: "Rennes",
  points: 55,
  birthday: Date.new(1990, 1, 1),
  description: "I am a test user.................",
  interest: "Cuisine"
)

# Génération d'une activité liée à l'utilisateur de test


Activity.create!(
  category: "Randonnée",
  title: "Test Activity",
  price_person: 50.0,
  content: "This is a test activity.",
  address: "Chantepie, france",
  start_date: DateTime.now + 7.days,
  end_date: DateTime.now + 14.days,
  user: User.first
)






# def seed pour DB :

# Génération des utilisateurs


3.times do |i|
  User.create!(
    email: "user#{i + 1}@example.com",
    password: "password",
    nickname: "User#{i + 1}",
    first_name: "First#{i + 1}",
    last_name: "Last#{i + 1}",
    address: CITIES.sample,
    points: rand(0..100),
    birthday: Date.today - rand(18..50).years,
    description: "Description....................................#{i + 1}",
    interest: USER_INTERESTS.sample,
  )
end

# Génération des activités
50.times do |i|
  user = User.order("RANDOM()").first
  address = CITIES.sample
  coordinates = Geocoder.coordinates(address)

  category = ACTIVITY_CATEGORIES.sample

  title_prefix = case category
                 when "Randonnée"
                   "Randonnée"
                 when "Concert"
                   "Concert"
                 when "Activité culinaire"
                   "Cuisine"
                 # Ajoutez d'autres catégories avec leurs préfixes correspondants ici
                 else
                   "Activité"
                 end

  Activity.create!(
    category: category,
    title: "#{title_prefix} #{i + 1}",
    price_person: rand(10..100),
    content: "Content123456789........#{i + 1}",
    address: address,
    latitude: coordinates[0],
    longitude: coordinates[1],
    start_date: DateTime.now + rand(1..30).days,
    end_date: DateTime.now + rand(31..60).days,
    user: user
  )
end
