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

User.create!(name:  "管理者A",
             email: "aaa@gmail.com",
             password: "aaaaaa",
             password_confirmation: "aaaaaa",
             admin: true)

10.times do |n|
  Label.create!(name: "test#{n + 1}")
end

10.times do |n|
  User.create!(name:  "test#{n + 1}",
               email: "test#{n + 1}@gmail.com",
               password: "password#{n + 1}",
               password_confirmation: "password#{n + 1}",
               admin: false)
end

10.times do |n|
  Task.create!(title: "test#{n + 1}",
               content: "test#{n + 1}",
               deadline: "02023-01-31",
               status: "working",
               priority: "高",
               user_id: 1)
end