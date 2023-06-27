# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb
User.destroy_all
Activity.destroy_all

# Méthode pour générer des coordonnées aléatoires en France
def random_coordinates_in_france
  latitude = rand(41.3..51.1)
  longitude = rand(-5.5..9.6)
  [latitude, longitude]
end

# def seed pour l'admin :
User.create!(
  email: "lolodu35@gmail.com",
  password: "123456",
  nickname: "LoloDu35",
  first_name: "Lauréne",
  last_name: "Freyer",
  address: "123 Test Street",
  points: 55,
  birthday: Date.new(1990, 1, 1),
  description: "I am a test user.................",
  interest: "Cuisine"
)

# Génération d'une activité liée à l'utilisateur de test
latitude, longitude = random_coordinates_in_france

Activity.create!(
  category: "Randonnée",
  latitude: latitude,
  longitude: longitude,
  title: "Test Activity",
  price_person: 50.0,
  content: "This is a test activity.",
  address: "456 Test Avenue",
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
    address: "Address#{i + 1}",
    points: rand(0..100),
    birthday: Date.today - rand(18..50).years,
    description: "Description....................................#{i + 1}",
    interest: "Cuisine"
  )
end

# Génération des activités
50.times do |i|
  user = User.order("RANDOM()").first
  latitude, longitude = random_coordinates_in_france

  Activity.create!(
    category: "Randonnée",
    latitude: latitude,
    longitude: longitude,
    title: "Randonnée#{i + 1}",
    price_person: rand(10..100),
    content: "Content123456789........#{i + 1}",
    address: "Address#{i + 1}",
    start_date: DateTime.now + rand(1..30).days,
    end_date: DateTime.now + rand(31..60).days,
    user: user
  )
end
