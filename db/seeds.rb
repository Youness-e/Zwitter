# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Create fake users
User.create!({
    :name => "youness.e",
    :email => "fake@test.com",
    :password => "test123",
    :password_confirmation => "test123"
})
50.times do |i|
    User.create!({
        :name => Faker::Name.name,
        :email => "fake-#{i}@test.com",
        :password => "test123",
        :password_confirmation => "test123"
    }) 
end

# Create random posts & follow
users = User.all
users.each do |user|
    # Inject posts
    Random.new.rand(0..25).times do
        date = Faker::Time.between(2.year.ago, Date.today, :all)
        user.posts << Post.new(:content => Faker::Lorem::sentence(5), :created_at => date)
    end
    # Inject follow
    users.sample(Random.new.rand(0..10)).each do |follower|        
        user.follow(follower) if user != follower
    end
end