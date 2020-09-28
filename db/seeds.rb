ad_user = User.create!(name:                   "管理者",
              username:              "adminuser",
              email:                 "adminuser@example.com",
              password:              "adminpass",
              password_confirmation: "adminpass",
              admin: true)

@micropost = ad_user.microposts.create!(content: "hoge")
@micropost.post_image.attach(io: File.open('db/fixtures/crop.jpg'), filename: "crop.jpg")

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

#usersのmicropost投稿
users = User.order(:created_at).take(10)
30.times do
  content = Faker::Lorem.sentence(word_count: 3)
  #Fakerで:contentを生成

  users.each { |user| @microposts = user.microposts.create!(content: content)
  @microposts.post_image.attach(io: File.open('db/fixtures/crop.jpg'), filename: "crop.jpg")}

end

#follow/unfollow
users = User.all
user  = users.first
following = users[2..20]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
