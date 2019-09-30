# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# (1..100).each do |n1|
#   User.create(name: "#{Faker::Name.first_name}-#{Faker::Name.last_name}")
# end

def random_user_id(nums)
  index = rand(nums.size)
  nums[index]
end

user_ids = []
(1..100).each do |n1|
  user = User.create(name: "#{Faker::Name.first_name}-#{Faker::Name.last_name}")
  if n1 == 1
    user_id = user.id
    user_ids = (user_id..user_id+99).to_a
  end

  (1..3).each do |n2|
    post = Post.create(title: "hello-kitty-#{n2}-user-#{user.id}", content: "12346567879345945", user_id: random_user_id(user_ids-[user.id]))
    (1..4).each do |n3|
      PostNotifier.create(post_id: post.id, notifier_id: random_user_id(user_ids-[user.id]))
    end
  end
end

puts user_ids
