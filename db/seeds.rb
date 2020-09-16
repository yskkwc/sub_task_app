User.create!(name:                   "管理者",
              username:              "adminuser",
              password:              "adminpass",
              password_confirmation: "adminpass",
              admin: true)

30.times do |n|
  name     = Faker::Name.name
  username = Faker::Name.name
  password = "password"
  User.create!(name:                   name,
                username:              username,
                password:              password,
                password_confirmation: password
              )
end
users = User.order(:created_at).take(6)
40.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
