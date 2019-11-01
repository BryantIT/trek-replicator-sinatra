5.times do
    User.create(username: Faker::Internet.username, password: Faker::Internet.password)
end
