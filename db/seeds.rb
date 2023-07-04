# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require_relative 'seeds_data/cities' # Chargement de la liste des villes

# db/seeds.rb
Rating.destroy_all
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
puts "Création admin..."

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
  description: "Koukou c'est moi lauréne et je suis trop cool. J'aime les chiens et les licornes. Appellé moi Lolo",
)
admin_interest_names = ["Cuisine", "Sport", "Voyage"]
admin_interests = admin_interest_names.map { |name| Interest.find_by(name: name) }

admin.interests << admin_interests
# Génération d'une activité liée à l'utilisateur de test

admin_photo = File.open(Rails.root.join("app", "assets", "images", "lolodu35.png"))
admin.photo.attach(io: admin_photo, filename: "admin.png", content_type: "image/png")
admin.save!

admin_activity_photo = URI.open("https://images.unsplash.com/photo-1606474226448-4aa808468efc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1990&q=80")
admin_activity = Activity.create!(
  category: "Randonnée",
  title: "Randonnée en forêt",
  price_person: 0,
  content: "Promenade en forêt de 2h",
  address: "Chantepie, France",
  max_participants: rand(5..10),
  start_date: DateTime.now + 7.days,
  end_date: DateTime.now + 8.days,
  user: admin
)

admin_activity.photo.attach(io: admin_activity_photo, filename: "admin_activity.jpg", content_type: "image/jpeg")







# def seed pour DB :

# Génération des utilisateurs
puts "Création des utilisateurs..."


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
  genre = genders.sample
  photo_url = case genre
              when "Homme"
                ["https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80", "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=999&q=80"].sample
              when "Femme"
                ["https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80", "https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"].sample
              else
                ["https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80", "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=999&q=80", "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80", "https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"].sample
              end

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
    genre: genre
  )
  users << user

  user_interest_names = USER_INTERESTS.sample(rand(1..3)) # Choix d'un à trois intérêts aléatoires
  user_interests = user_interest_names.map { |name| Interest.find_by(name: name) }

  user.interests << user_interests

  user_photo = URI.open(photo_url)
  user.photo.attach(io: user_photo, filename: "user#{i + 1}.png", content_type: "image/png")
  user.save!
end



puts "Création des activitées..."

# Génération des activités
50.times do |i|
  user = users.sample
  address = CITIES.sample
  coordinates = Geocoder.coordinates(address)

  category = ACTIVITY_CATEGORIES.sample
  puts "Activité #{i + 1} générée"

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

  photo_url = case category
              when "Randonnée"
                "https://images.unsplash.com/photo-1486179814561-91c2d61316b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Evénement sportif"
                "https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Sport/Fitness"
                "https://images.unsplash.com/photo-1518611012118-696072aa579a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Concert"
                "https://images.unsplash.com/photo-1501386761578-eac5c94b800a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Sortie en ville"
                "https://images.unsplash.com/photo-1485872299829-c673f5194813?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1460&q=80"
              when "Gastronomie"
                "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Voyage"
                "https://images.unsplash.com/photo-1501426026826-31c667bdf23d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1336&q=80"
              when "Visite"
                "https://images.unsplash.com/photo-1518998053901-5348d3961a04?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"
              when "Jeux"
                "https://images.unsplash.com/photo-1561034645-e6f28dfddd2c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Sortie culturelle"
                "https://images.unsplash.com/photo-1526817609938-a708708cf90f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80"
              when "Bénévolat"
                "https://images.unsplash.com/photo-1565803974275-dccd2f933cbb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2342&q=80"
              when "Vie quotidienne"
                "https://images.unsplash.com/photo-1611843467160-25afb8df1074?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Cinéma"
                "https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when "Plein air"
                "https://images.unsplash.com/photo-1578359968130-76b59bb5af13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"
              when "Atelier"
                "https://images.unsplash.com/photo-1544928147-79a2dbc1f389?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"
              else
                "https://images.unsplash.com/photo-1511988617509-a57c8a288659?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2342&q=80"
              end

  activity_photo = URI.open(photo_url)

  Activity.create!(
    category: category,
    title: "#{title_prefix}",
    price_person: rand(0..100),
    content: content,
    address: address,
    latitude: coordinates[0],
    longitude: coordinates[1],
    max_participants: rand(1..20),
    start_date: DateTime.now + rand(1..30).days,
    end_date: DateTime.now + rand(31..60).days,
    user: user
  ).photo.attach(io: activity_photo, filename: "activity#{i + 1}.jpg", content_type: "image/jpeg")

  Activity.all.each do |activity|
    Chatroom.create!(
      activity: activity,
      name: activity.title
    )
  end


end

puts "Création des likes..."

# Génération de likes aléatoires pour l'admin
activities = Activity.all
admin_likes = activities.sample(rand(1..5)) # Génère entre 1 et 5 likes aléatoires
admin_likes.each do |activity|
  Like.create(user: admin, activity: activity)
end

puts "Création des ratings..."

# création de ratings aléatoires pour l'admin
admin_ratings = activities.sample(rand(1..5))
admin_ratings.each do |activity|
  Rating.create(user: admin, activity: activity, note: rand(0..5))
end

# Génération d'une demande de réservation pour l'admin
user = User.where.not(id: admin.id).sample
activity = Activity.where.not(user_id: admin.id).sample
Reservation.create(user: user, activity: activity, status: "en attente")
puts "Terminé ! Merci de ta patience :)"

30.times do
  user = User.where.not(id: admin.id).sample
  user_ratings = activities.sample(rand(1..5))
  user_ratings.each do
    Rating.create(user: user, activity: activity, note: rand(0..5))
  end
end
