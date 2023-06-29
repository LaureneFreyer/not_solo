# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require_relative 'seeds_data/cities' # Chargement de la liste des villes

# db/seeds.rb
Message.destroy_all
Chatroom.destroy_all
Reservation.destroy_all
Like.destroy_all
User.destroy_all
Activity.destroy_all
Interest.destroy_all

ACTIVITY_CATEGORIES = Activity::CATEGORIES

interests = [
  "Cuisine", "Sport", "Danse", "Voyage", "Art", "Cinéma", "Musique", "Animaux",
  "Technologie", "Méditation", "Jeux de société", "Jeux vidéo", "Nature",
  "Photographie", "Bricolage", "Lecture", "Mode", "Sciences", "Sorties",
  "Automobile", "Jardinage", "Services", "Randonnées", "Découvertes",
  "Séries", "Nourriture", "Autres"
]

interest_objects = interests.map do |interest_name|
  Interest.create(name: interest_name)
end


USER_INTERESTS = [
  "Cuisine", "Sport", "Danse", "Voyage", "Art", "Cinéma", "Musique", "Animaux",
  "Technologie", "Méditation", "Jeux de société", "Jeux vidéo", "Nature",
  "Photographie", "Bricolage", "Lecture", "Mode", "Sciences", "Sorties",
  "Automobile", "Jardinage", "Services", "Randonnées", "Découvertes",
  "Séries", "Nourriture", "Autres"
]

# Méthode pour générer des coordonnées aléatoires en France

# def seed pour l'admin :
admin = User.create!(
  email: "lolodu35@gmail.com",
  password: "123456",
  nickname: "LoloDu35",
  first_name: "Laurène",
  last_name: "Freyer",
  genre: "Femme",
  address: "Rennes",
  points: 55,
  birthday: Date.new(1997, 3, 16),
  description: "Koukou c'est moi lauréne et je suis trop cool. J'aime les chats et les licornes. Appellé moi Lolo",
)
admin_interest_names = ["Cuisine", "Sport", "Voyage"]
admin_interests = admin_interest_names.map { |name| Interest.find_by(name: name) }

admin.interests << admin_interests
# Génération d'une activité liée à l'utilisateur de test


Activity.create!(
  category: "Randonnée",
  title: "Randonnée en forêt",
  price_person: 0,
  content: "Promenade en forêt de 2h",
  address: "Chantepie, france",
  max_participants: rand(5..10),
  start_date: DateTime.now + 7.days,
  end_date: DateTime.now + 8.days,
  user: User.first
)






# def seed pour DB :

# Génération des utilisateurs


first_names = ["Bob", "Charlie", "Alice", "John", "Jane", "Emma", "Lucas", "Liam", "Oliver", "Amelia"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Wilson"]

descriptions = [
  "J'adore les activités en plein air et rencontrer de nouvelles personnes.",
  "Un grand amateur de livres et de cinéma, toujours prêt à découvrir de nouvelles choses.",
  "Passionné par la technologie et les jeux vidéo. J'aime aussi la randonnée et le camping.",
  "Fervent amateur de cuisine, toujours prêt à essayer de nouvelles recettes.",
  "Je suis un passionné de musique et je joue de plusieurs instruments.",
  "J'aime voyager et découvrir de nouvelles cultures.",
  "Amateur de sport, j'aime aussi passer du temps à lire et à me détendre.",
  "Je suis un amoureux des animaux et j'adore passer du temps dans la nature.",
  "J'aime les activités artistiques et créatives, comme la peinture et le dessin.",
  "Passionné de photographie, j'aime capturer les beaux moments de la vie."
]

genders = ["Homme", "Femme", "Non binaire", "Autre"]

users = []
3.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    password: "password",
    nickname: "#{first_names.sample}#{i + 1}",
    first_name: first_names.sample,
    last_name: last_names.sample,
    address: CITIES.sample,
    points: rand(0..100),
    birthday: Date.today - rand(18..50).years,
    description: descriptions.sample,
    genre: genders.sample
  )
  users << user

  user_interest_names = USER_INTERESTS.sample(rand(1..3)) # Choisit un à trois intérêts aléatoires
  user_interests = user_interest_names.map { |name| Interest.find_by(name: name) }

  user.interests << user_interests
end



# Génération des activités
50.times do |i|
  user = users.sample
  address = CITIES.sample
  coordinates = Geocoder.coordinates(address)

  category = ACTIVITY_CATEGORIES.sample

  title_prefix = case category
  when "Evénement sportif"
    ["Evénement Sportif", "Championnat local", "Course de rue"].sample
  when "Sport/Fitness"
    ["Session Fitness", "Cours de Yoga", "Entraînement de crossfit"].sample
  when "Concert"
    ["Concert de Jazz", "Concert de Rock", "Concert Classique"].sample
  when "Sortie en ville"
    ["Visite du centre-ville", "Découverte des monuments", "Balade en ville"].sample
  when "Randonnée"
    ["Randonnée en montagne", "Balade en forêt", "Découverte de sentiers"].sample
  when "Gastronomie"
    ["Dégustation Gastronomique", "Atelier de cuisine", "Découverte culinaire"].sample
  when "Voyage"
    ["Voyage à la mer", "Excursion à la montagne", "Voyage en ville"].sample
  when "Visite"
    ["Visite Guidée du musée", "Tour de la ville", "Découverte historique"].sample
  when "Jeux"
    ["Soirée Jeux", "Tournoi de cartes", "Jeux de société"].sample
  when "Sortie culturelle"
    ["Visite Culturelle", "Exposition d'art", "Découverte historique"].sample
  when "Bénévolat"
    ["Mission Bénévolat", "Aide communautaire", "Projet de volontariat"].sample
  when "Vie quotidienne"
    ["Activité Quotidienne", "Cours de bricolage", "Atelier de jardinage"].sample
  when "Cinéma"
    ["Projection de film", "Festival du film", "Ciné-club"].sample
  when "Plein air"
    ["Activité en Plein Air", "Pique-nique au parc", "Journée à la plage"].sample
  when "Atelier"
    ["Atelier de peinture", "Cours de sculpture", "Atelier de bricolage"].sample
  else
    ["Activité", "Événement", "Réunion"].sample
end

content = case category
when "Evénement sportif"
  ["Venez participer à un événement sportif passionnant.", "Rejoignez-nous pour une compétition sportive divertissante.", "Participez à notre événement sportif et montrez vos compétences."].sample
when "Sport/Fitness"
  ["Participez à notre session de fitness pour rester en forme.", "Venez pour un entraînement intense.", "Rejoignez-nous pour une séance de fitness dynamique."].sample
when "Concert"
  ["Profitez d'un concert de musique en direct.", "Venez écouter de la musique live à notre concert.", "Assistez à notre concert et appréciez la musique live."].sample
when "Sortie en ville"
  ["Découvrez la beauté de notre ville.", "Venez explorer la ville avec nous.", "Rejoignez-nous pour une visite guidée de la ville."].sample
when "Randonnée"
  ["Venez pour une randonnée revigorante.", "Profitez de la nature lors de notre randonnée.", "Rejoignez-nous pour une aventure en randonnée."].sample
when "Gastronomie"
  ["Venez déguster de délicieuses spécialités.", "Rejoignez-nous pour un atelier culinaire.", "Découvrez la cuisine locale lors de notre dégustation gastronomique."].sample
when "Voyage"
  ["Participez à un voyage inoubliable.", "Venez découvrir de nouveaux horizons.", "Rejoignez-nous pour une escapade mémorable."].sample
when "Visite"
  ["Découvrez l'histoire de notre région.", "Venez pour une visite guidée.", "Rejoignez-nous pour une visite culturelle."].sample
when "Jeux"
  ["Venez pour une soirée de jeux divertissants.", "Participez à notre tournoi de jeux.", "Rejoignez-nous pour une soirée de jeux de société."].sample
when "Sortie culturelle"
  ["Découvrez l'art et la culture locaux.", "Venez pour une visite culturelle.", "Rejoignez-nous pour une sortie culturelle."].sample
when "Bénévolat"
  ["Venez aider la communauté.", "Participez à notre mission de bénévolat.", "Rejoignez-nous pour un projet de volontariat."].sample
when "Vie quotidienne"
  ["Participez à notre atelier quotidien.", "Venez pour un cours de bricolage.", "Rejoignez-nous pour un atelier de jardinage."].sample
when "Cinéma"
  ["Venez pour une projection de film.", "Participez à notre festival du film.", "Rejoignez-nous pour une soirée cinéma."].sample
when "Plein air"
  ["Venez pour une activité en plein air.", "Participez à notre pique-nique au parc.", "Rejoignez-nous pour une journée à la plage."].sample
when "Atelier"
  ["Venez pour un atelier de peinture.", "Participez à notre cours de sculpture.", "Rejoignez-nous pour un atelier de bricolage."].sample
else
  ["Venez pour une activité divertissante.", "Participez à notre événement.", "Rejoignez-nous pour une réunion intéressante."].sample
end

  Activity.create!(
    category: category,
    title: "#{title_prefix} #{i + 1}",
    price_person: rand(0..100),
    content: content,
    address: address,
    latitude: coordinates[0],
    longitude: coordinates[1],
    max_participants: rand(1..20),
    start_date: DateTime.now + rand(1..30).days,
    end_date: DateTime.now + rand(31..60).days,
    user: user
  )
end
