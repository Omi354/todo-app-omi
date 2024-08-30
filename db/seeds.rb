# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
john = User.find(1)
emily = User.find(2)


john.boards.each do |board|
    2.times do
        board.tasks.create!(
            user: john,
            name: Faker::Lorem.sentence(word_count: 5),
            desc: Faker::Lorem.sentence(word_count: 10)
        )
    end
end

emily.boards.each do |board|
    2.times do
        board.tasks.create!(
            user: emily,
            name: Faker::Lorem.sentence(word_count: 5),
            desc: Faker::Lorem.sentence(word_count: 10)
        )
    end
end

# 5.times do
#     john.tasks.create!(
#         name: Faker::Lorem.sentence(word_count: 5),
#         desc: Faker::Lorem.sentence(word_count: 10)
#     )
# end

# 5.times do
#     emily.tasks.create(
#         name: Faker::Lorem.sentence(word_count: 5),
#         desc: Faker::Lorem.sentence(word_count: 10)
#     )
# end