namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Flavia",
                         email: "flaflifle@hotmail.it",
                         password: "123456",
                         password_confirmation: "123456")
    admin.toggle!(:admin)
    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@petsquare.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    10.times do |n|
      namePet = "pet#{n+1}"
      breed= "dog"
      description="funny"
      users.each { |user| user.pets.create!(namePet: "#{namePet} #{user.name}",
                                            breed: breed,
                                            description: description) }
    end

    #da provare
    def make_relationships
      users = User.all(limit: 6)
      50.times do |i|
        followed=Pet.find(i+1)
        users.each{ |followed| user.follow!(followed)}
      end
    end

  end

  desc "add mock places in DB"
  task :places => :environment do
    lat,lon = 45.071069,7.685231
    5.times do |i|
      lat -= 0.01
      Place.create name:"localita' #{i}", street:Faker::Address.street_name, city:Faker::Address.city,
                   country:Faker::Address.country, latitude:lat, longitude:lon, category:"Parco", gmaps:true
    end
  end

end