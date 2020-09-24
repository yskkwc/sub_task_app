User.create!(name:                   "管理者",
              username:              "adminuser",
              email:                 "adminuser@example.com",
              password:              "adminpass",
              password_confirmation: "adminpass",
              admin: true)

30.times do |n|
  name     = Faker::Name.name
  username = name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:                   name,
                username:              username,
                email:                 email,
                password:              password,
                password_confirmation: password
              )
end

#userのmicropost投稿
users = User.order(:created_at).take(6)

40.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content)}
end



#relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
