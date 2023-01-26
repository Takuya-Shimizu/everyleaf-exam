1.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: "password",
               admin: false)
end

User.create!(name:  "管理者D",
             email: "ddd@gmail.com",
             password:  "dddddddd",
             password_confirmation: "dddddddd",
             admin: true)