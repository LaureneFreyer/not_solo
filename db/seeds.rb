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
  "Automobile", "Jardinage", "Services", "Randonnée", "Découvertes",
  "Séries", "Nourriture", "Autres"
]

interest_objects = interests.map do |interest_name|
  Interest.create(name: interest_name)
end


USER_INTERESTS = [
  "Cuisine", "Sport", "Danse", "Voyage", "Art", "Cinéma", "Musique", "Animaux",
  "Technologie", "Méditation", "Jeux de société", "Jeux vidéo", "Nature",
  "Photographie", "Bricolage", "Lecture", "Mode", "Sciences", "Sorties",
  "Automobile", "Jardinage", "Services", "Randonnée", "Découvertes",
  "Séries", "Nourriture", "Autres"
]

# Méthode pour générer des coordonnées aléatoires en France
puts "Création admin..."

# def seed pour l'admin :
admin = User.create!(
  email: "henri33@gmail.com",
  password: "123456",
  nickname: "Henri",
  first_name: "Henri",
  last_name: "Le Borgne",
  genre: "Homme",
  address: "Bordeaux",
  points: 75,
  birthday: Date.new(1983, 3, 18),
  description: "Je me présente, je m'appelle Henri. J'aimerais bien réussir ma vie, être aimé, être beau, gagner de l'argent, mais surtout être intelligent. Et me faire pleins de nouveaux amis."
)
admin_interest_names = ["Musique", "Nature", "Voyage"]
admin_interests = admin_interest_names.map { |name| Interest.find_by(name: name) }

admin.interests << admin_interests
# Génération d'une activité liée à l'utilisateur de test

admin_photo = File.open(Rails.root.join("app", "assets", "images", "daniel.jpg"))
admin.photo.attach(io: admin_photo, filename: "admin.png", content_type: "image/png")
admin.save!

start_date_admin = DateTime.now + 7.days
start_date_admin = start_date_admin.change(min: (start_date_admin.min / 15).round * 15) + 1
admin_activity_photo = URI.open("https://images.unsplash.com/photo-1531932768276-eb8b0770c5af?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80")
admin_activity = Activity.create!(
  category: "Randonnée",
  title: "Dans les vignes",
  price_person: 0,
  content: "Petite promenade degustative dans les vignes du château margaux. Durée prévu environ 2h, à adapter selon les personnes qui sont intéressées.",
  address: "Château Margaux, Margaux-Cantenac, France",
  max_participants: rand(5..10),
  start_date: start_date_admin,
  user: admin
)

admin_activity.photo.attach(io: admin_activity_photo, filename: "admin_activity.jpg", content_type: "image/jpeg")






# def seed pour DB :

# Génération des utilisateurs
puts "Création des utilisateurs..."
puts "   / \\__"

last_names = ["Dubois", "Durand", "Leroy", "Moreau", "Simon", "Laurent", "Lefebvre", "Michel", "Garcia", "Rodriguez"]

first_names_masculin = ["Thomas", "Nicolas", "Maxime", "Alexandre", "Antoine", "Lucas", "Hugo", "Romain", "Julien", "Rémi"]
first_names_feminin = ["Sarah", "Julie", "Camille", "Léa", "Manon", "Chloé", "Emma", "Anaïs", "Émilie", "Sophie"]


descriptions_masculin = [
  "J'adore les activités en plein air et rencontrer de nouvelles personnes.",
  "Un grand amateur de livres et de cinéma, toujours prêt à découvrir de nouvelles choses.",
  "Passionné par la technologie et les jeux vidéo. J'aime aussi la randonnée et le camping.",
  "Fervent amateur de cuisine, toujours prêt à essayer de nouvelles recettes.",
  "Je suis un passionné de musique et je joue de plusieurs instruments."
]

descriptions_feminin = [
  "J'adore les activités en plein air et rencontrer de nouvelles personnes.",
  "Une grande amatrice de livres et de cinéma, toujours prête à découvrir de nouvelles choses.",
  "Passionnée par la technologie et les jeux vidéo. J'aime aussi la randonnée et le camping.",
  "Fervente amatrice de cuisine, toujours prête à essayer de nouvelles recettes.",
  "Je suis une passionnée de musique et je joue de plusieurs instruments."
]


genders = ["Homme", "Femme"]

users = []

4.times do |i|
  genre = genders.sample
  photo_url = case genre
              when "Homme"
                ["https://images.unsplash.com/photo-1590086782957-93c06ef21604?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80", "https://images.unsplash.com/photo-1564564321837-a57b7070ac4f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2352&q=80", "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80", "https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=999&q=80"].sample
              when "Femme"
                ["https://images.unsplash.com/photo-1481214110143-ed630356e1bb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80","https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2342&q=80","https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80", "https://images.unsplash.com/photo-1491349174775-aaafddd81942?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"].sample
              end


  case genre
  when "Homme"
    first_name = first_names_masculin.sample
    description = descriptions_masculin.sample

  when "Femme"
    first_name = first_names_feminin.sample
    description = descriptions_feminin.sample
  end

  user = User.create!(
    email: "user#{i + 1}@example.com",
    password: "password",
    nickname: "#{first_name} #{last_names.sample[0].capitalize}",
    first_name: first_name,
    last_name: last_names.sample,
    address: CITIES_BORDEAUX.sample,
    points: rand(0..100),
    birthday: Date.today - rand(21..34).years,
    description: description,
    genre: genre
  )

  users << user

  user_interest_names = USER_INTERESTS.sample(rand(2..3)) # Choix deux à trois intérêts aléatoires
  user_interests = user_interest_names.map { |name| Interest.find_by(name: name) }

  user.interests << user_interests

  user_photo = URI.open(photo_url)
  user.photo.attach(io: user_photo, filename: "user#{i + 1}.png", content_type: "image/png")
  user.save!
end
# Génération des activités
puts " (    @\\___    Rennes en cours..... 10 minutes restantes"

# Génération des activités
5.times do |i|
  user = users.sample
  category = ACTIVITY_CATEGORIES.sample
  # puts "Activité #{i + 1} générée"

  title_prefix = case category
  when "Evénement sportif"
    ["Evénement Sportif", "Championnat local", "Course de rue"].sample
  when "Sport/Fitness"
    ["Session Fitness", "Cours de Yoga", "Crossfit"].sample
  when "Concert"
    ["Concert de Jazz", "Concert de Rock", "Concert Classique"].sample
  when "Sortie en ville"
    ["Visite du centre", "Visite de monuments", "Balade en ville"].sample
  when "Randonnée"
    ["Sortie en montagne", "Balade en forêt", "Balade sur sentiers"].sample
  when "Gastronomie"
    ["Dégustation Gastro", "Atelier de cuisine", "Découverte culinaire"].sample
  when "Voyage"
    ["Voyage à la mer", "Voyage en montagne", "Voyage en ville"].sample
  when "Visite"
    ["Visite Guidée", "Tour de la ville", "Monuments phares"].sample
  when "Jeux"
    ["Soirée Jeux", "Tournoi de cartes", "Jeux de société"].sample
  when "Sortie culturelle"
    ["Visite Culturelle", "Exposition d'art", "Sortie au musée"].sample
  when "Bénévolat"
    ["Mission Bénévolat", "Aide communautaire", "Projet volontariat"].sample
  when "Vie quotidienne"
    ["Activité Quotidienne", "Cours bricolage", "Atelier jardinage"].sample
  when "Cinéma"
    ["Projection de film", "Festival du film", "Ciné-club"].sample
  when "Plein air"
    ["Activité Plein Air", "Pique-nique", "Journée plage"].sample
  when "Atelier"
    ["Atelier peinture", "Cours sculpture", "Atelier bricolage"].sample
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

  address = case category
  when "Evénement sportif"
    "111 Rue de Lorient, 35000 Rennes"
  when "Sport/Fitness"
    "8 Rue de la Donelière, 35000 Rennes"
  when "Concert"
    "1 Esplanade Charles de Gaulle, 35000 Rennes"
  when "Sortie en ville"
    "Rennes"
  when "Randonnée"
    "Place Saint-Mélaine, 35000 Rennes"
  when "Gastronomie"
    "2 Rue des Carmes, 35000 Rennes"
  when "Voyage"
    "6 Rue Pierre Martin, 35000 Rennes"
  when "Visite"
    "20 Quai Emile Zola, 35000 Rennes"
  when "Jeux"
    "11 Boulevard Magenta, 35000 Rennes"
  when "Sortie culturelle"
    "Place de la Mairie, 35000 Rennes"
  when "Bénévolat"
    "10 Rue Louis Guilloux, 35000 Rennes"
  when "Vie quotidienne"
    "2 Rue du Pré du Bois, 35000 Rennes"
  when "Cinéma"
    "12 Rue Yvonne Jean-Haffen, 35000 Rennes"
  when "Plein air"
    "4 Avenue des Gayeulles, 35700 Rennes"
  when "Atelier"
    "24 Rue Hoche, 35000 Rennes"
  else
    "Rennes"
  end

  coordinates = Geocoder.coordinates(address)

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

  start_date = DateTime.now + rand(1..30).days
  start_date = start_date.change(min: (start_date.min / 15).round * 15)

  end_date = start_date + rand(1..6).hours
  minutes = (rand(0..3) * 15)

Activity.create!(
  category: category,
  title: "#{title_prefix}",
  price_person: rand(0..100),
  content: content,
  address: address,
  latitude: coordinates[0],
  longitude: coordinates[1],
  max_participants: rand(2..20),
  start_date: start_date + rand(0..6).hours + minutes.minutes,
  end_date: end_date,
  user: user
  ).photo.attach(io: activity_photo, filename: "activity#{i + 1}.jpg", content_type: "image/jpeg")
rescue => e
  puts "Erreur lors de la création de l'activité #{title_prefix} #{i+1}: #{e.message}"
  puts "Adresse: #{address}"
  next

print_progress_bar(i + 1, activities_data.length)

  Activity.all.each do |activity|
    Chatroom.create!(
      activity: activity,
      name: activity.title
    )
  end
end


puts "  /         O    Nan je deconne, Bordeaux en cours....  "



# puts "Création des activitées..."

# Génération des activités
10.times do |i|
  user = users.sample
  address = CITIES.sample
  coordinates = Geocoder.coordinates(address)

  category = ACTIVITY_CATEGORIES.sample

  title_prefix = case category
  when "Evénement sportif"
    ["Evénement Sportif", "Championnat local", "Course de rue"].sample
  when "Sport/Fitness"
    ["Session Fitness", "Cours de Yoga", "Crossfit"].sample
  when "Concert"
    ["Concert de Jazz", "Concert de Rock", "Concert Classique"].sample
  when "Sortie en ville"
    ["Visite du centre", "Visite de monuments", "Balade en ville"].sample
  when "Randonnée"
    ["Sortie en montagne", "Balade en forêt", "Balade sur sentiers"].sample
  when "Gastronomie"
    ["Dégustation Gastro", "Atelier de cuisine", "Découverte culinaire"].sample
  when "Voyage"
    ["Voyage à la mer", "Voyage en montagne", "Voyage en ville"].sample
  when "Visite"
    ["Visite Guidée", "Tour de la ville", "Monuments phares"].sample
  when "Jeux"
    ["Soirée Jeux", "Tournoi de cartes", "Jeux de société"].sample
  when "Sortie culturelle"
    ["Visite Culturelle", "Exposition d'art", "Sortie au musée"].sample
  when "Bénévolat"
    ["Mission Bénévolat", "Aide communautaire", "Projet volontariat"].sample
  when "Vie quotidienne"
    ["Activité Quotidienne", "Cours bricolage", "Atelier jardinage"].sample
  when "Cinéma"
    ["Projection de film", "Festival du film", "Ciné-club"].sample
  when "Plein air"
    ["Activité Plein Air", "Pique-nique", "Journée plage"].sample
  when "Atelier"
    ["Atelier peinture", "Cours sculpture", "Atelier bricolage"].sample
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

  start_date = DateTime.now + rand(1..30).days
  start_date = start_date.change(min: (start_date.min / 15).round * 15)

  end_date = start_date + rand(1..6).hours
  minutes = (rand(0..3) * 15)

Activity.create!(
  category: category,
  title: "#{title_prefix}",
  price_person: rand(0..100),
  content: content,
  address: address,
  latitude: coordinates[0],
  longitude: coordinates[1],
  max_participants: rand(2..20),
  start_date: start_date + rand(0..6).hours + minutes.minutes,
  end_date: end_date,
  user: user
  ).photo.attach(io: activity_photo, filename: "activity#{i + 1}.jpg", content_type: "image/jpeg")

  Activity.all.each do |activity|
    Chatroom.create!(
      activity: activity,
      name: activity.title
    )
  end


end

# Génération des activités
10.times do |i|
  user = users.sample
  category = ACTIVITY_CATEGORIES.sample
  # puts "Activité #{i + 1} générée"

  title_prefix = case category
  when "Evénement sportif"
    ["Evénement Sportif", "Championnat local", "Course de rue"].sample
  when "Sport/Fitness"
    ["Session Fitness", "Cours de Yoga", "Crossfit"].sample
  when "Concert"
    ["Concert de Jazz", "Concert de Rock", "Concert Classique"].sample
  when "Sortie en ville"
    ["Visite du centre", "Visite de monuments", "Balade en ville"].sample
  when "Randonnée"
    ["Sortie en montagne", "Balade en forêt", "Balade sur sentiers"].sample
  when "Gastronomie"
    ["Dégustation Gastro", "Atelier de cuisine", "Découverte culinaire"].sample
  when "Voyage"
    ["Voyage à la mer", "Voyage en montagne", "Voyage en ville"].sample
  when "Visite"
    ["Visite Guidée", "Tour de la ville", "Monuments phares"].sample
  when "Jeux"
    ["Soirée Jeux", "Tournoi de cartes", "Jeux de société"].sample
  when "Sortie culturelle"
    ["Visite Culturelle", "Exposition d'art", "Sortie au musée"].sample
  when "Bénévolat"
    ["Mission Bénévolat", "Aide communautaire", "Projet volontariat"].sample
  when "Vie quotidienne"
    ["Activité Quotidienne", "Cours bricolage", "Atelier jardinage"].sample
  when "Cinéma"
    ["Projection de film", "Festival du film", "Ciné-club"].sample
  when "Plein air"
    ["Activité Plein Air", "Pique-nique", "Journée plage"].sample
  when "Atelier"
    ["Atelier peinture", "Cours sculpture", "Atelier bricolage"].sample
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

  address = case category
  when "Evénement sportif"
    "Cours Jules Ladoumegue, 33300 Bordeaux"
  when "Sport/Fitness"
    "9 Rue Fondaudège, 33000 Bordeaux"
  when "Concert"
    "Rue de Grassi, 33300 Bordeaux"
  when "Sortie en ville"
    "Bordeaux"
  when "Randonnée"
    "1679 Route de Bordeaux, 40460 Sanguinet"
  when "Gastronomie"
    "Place de la Comédie, 33000 Bordeaux"
  when "Voyage"
    "La Teste-de-Buch"
  when "Visite"
    "20 Cours Pasteur, 33000 Bordeaux"
  when "Jeux"
    "14 Rue Saint-Sernin, 33000 Bordeaux"
  when "Sortie culturelle"
    "13 Rue Thiac, 33000 Bordeaux"
  when "Bénévolat"
    "43 Rue Deyries, 33000 Bordeaux"
  when "Vie quotidienne"
    "73 Rue Camille Sauvageau, 33800 Bordeaux"
  when "Cinéma"
    "15 Rue Georges Bonnac, 33000 Bordeaux"
  when "Plein air"
    "Rue du Bocage, 33000 Bordeaux"
  when "Atelier"
    "73 Rue Camille Sauvageau, 33800 Bordeaux"
  else
    "Bordeaux"
  end

  coordinates = Geocoder.coordinates(address)

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

  start_date = DateTime.now + rand(1..30).days
  start_date = start_date.change(min: (start_date.min / 15).round * 15)

  end_date = start_date + rand(1..6).hours
  minutes = (rand(0..3) * 15)

Activity.create!(
  category: category,
  title: "#{title_prefix}",
  price_person: rand(0..100),
  content: content,
  address: address,
  latitude: coordinates[0],
  longitude: coordinates[1],
  max_participants: rand(2..20),
  start_date: start_date + rand(0..6).hours + minutes.minutes,
  end_date: end_date,
  user: user
  ).photo.attach(io: activity_photo, filename: "activity#{i + 1}.jpg", content_type: "image/jpeg")
rescue => e
  puts "Erreur lors de la création de l'activité #{title_prefix} #{i+1}: #{e.message}"
  puts "Adresse: #{address}"
  next

print_progress_bar(i + 1, activities_data.length)

  Activity.all.each do |activity|
    Chatroom.create!(
      activity: activity,
      name: activity.title
    )
  end
end

# //////// nouvelles activity pour le DemoDay ////////

# Génération des activités plein air
plein_air_titles = [
  "Randonnée en forêt",
  "Balade à vélo",
  "Journée barbecue",
  "Escalade outdoor",
  "Pique-nique"
]

5.times do |i|
  user = users.sample
  address = CITIES_BORDEAUX.sample
  coordinates = Geocoder.coordinates(address)

  category = "Plein air"
  title = plein_air_titles[i]
  description = "Une activité en plein air pour profiter de la nature et se détendre."

  photo_url = case i
              when 0
                "https://plus.unsplash.com/premium_photo-1663013023375-0cd892c02306?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when 1
                "https://images.unsplash.com/photo-1541625602330-2277a4c46182?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when 2
                "https://images.unsplash.com/photo-1579405317876-9340f1d26061?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"
              when 3
                "https://images.unsplash.com/photo-1485975638457-e191693003d0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"
              when 4
                "https://images.unsplash.com/photo-1618031312993-f93038f30365?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1335&q=80"
              end

  start_date = DateTime.now + rand(1..30).days
  start_date = start_date.change(min: (start_date.min / 15).round * 15)
  end_date = start_date + rand(1..6).hours
  minutes = (rand(0..3) * 15)

  Activity.create!(
    title: title,
    content: description,
    category: category,
    user: user,
    address: address,
    latitude: coordinates[0],
    longitude: coordinates[1],
    max_participants: rand(2..20),
    start_date: start_date + rand(0..6).hours,
    end_date: end_date,
  ).photo.attach(io: URI.open(photo_url), filename: "activity#{i + 99}.png", content_type: "image/png")
end

Activity.all.each do |activity|
  Chatroom.create!(
    activity: activity,
    name: activity.title
  )
end

# Génération des activités plein air
title_sport = ["Tournoi de football",
  "Match de tennis",
  "Course de marathon",
  "Match de basket",
  "Match de rugby"]


5.times do |i|
  user = users.sample
  address = CITIES.sample
  coordinates = Geocoder.coordinates(address)

  category = "Evénement sportif"
  title = title_sport[i]
  description = "Un événement sportif passionnant pour les amateurs de sport."

  photo_url = case i
              when 0
                "https://images.unsplash.com/photo-1553778263-73a83bab9b0c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2342&q=80"
              when 1
                "https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              when 2
                "https://images.unsplash.com/photo-1551927336-09d50efd69cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2352&q=80"
              when 3
                "https://images.unsplash.com/photo-1562519819-016930ada31b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80"
              when 4
                "https://images.unsplash.com/photo-1512299286776-c18be8ed6a1a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2340&q=80"
              end

  start_date = DateTime.now + rand(1..30).days
  start_date = start_date.change(min: (start_date.min / 15).round * 15)
  end_date = start_date + rand(1..6).hours
  minutes = (rand(0..3) * 15)


  Activity.create!(
    title: title,
    content: description,
    category: category,
    user: user,
    address: address,
    latitude: coordinates[0],
    longitude: coordinates[1],
    max_participants: rand(2..20),
    start_date: start_date + rand(0..6).hours + minutes.minutes,
    end_date: end_date,
  ).photo.attach(io: URI.open(photo_url), filename: "activity#{i + 1}.png", content_type: "image/png")
end


puts " /   (_____/     les activités sont générées ! Place aux likes... "


# Génération de likes aléatoires pour l'admin
activities = Activity.all
admin_likes = activities.sample(rand(5..6)).reject { |activity| activity.user == admin } # Génère d likes aléatoires en excluant les activités de l'admin
admin_likes.each do |activity|
  Like.create(user: admin, activity: activity)
end

# Pour les autres utilisateurs
users.each do |user|
  likes = activities.sample(rand(5..6)).reject { |activity| activity.user == user } # Génère d likes aléatoires en excluant les activités de l'utilisateur actuel
  likes.each do |activity|
    Like.create(user: user, activity: activity)
  end
end

# puts "Création des ratings..."

# création de ratings aléatoires pour l'admin
admin_ratings = activities.sample(rand(3..5))
admin_ratings.each do |activity|
  Rating.create(user: admin, activity: activity, note: 5)
end
puts "/_____/   U    une reservation est en cours..."

# Génération d'une demande de réservation pour l'admin
user = User.where.not(id: admin.id).sample
activity = Activity.where.not(user_id: admin.id).sample
Reservation.create(user: user, activity: activity, status: "en attente")

30.times do
  user = User.where.not(id: admin.id).sample
  user_ratings = activities.sample(rand(1..5))
  user_ratings.each do
    Rating.create(user: user, activity: activity, note: rand(4..5))
  end
end
puts "Terminé ! Merci de ta patience :)"
