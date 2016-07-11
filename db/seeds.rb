# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Restaurant.delete_all
Menu.delete_all
FoodItem.delete_all
Category.delete_all
Post.delete_all
Checkin.delete_all
Review.delete_all


User.create(:first_name => "Muhammad" , :last_name => "Tayyab" , :email => "muhammad.tayyabmukhtar@yahoo.com" ,:gender => 'male' , :password => '123456789')

10.times do |c|
	Category.create(:name => Faker::SlackEmoji.food_and_drink)
end

5.times do |t|
	Restaurant.create(:name => Faker::Company.name , :opening_time => Faker::Time.between(DateTime.now - 1, DateTime.now) , :closing_time => Faker::Time.between(DateTime.now - 1, DateTime.now), :location => Faker::Address.street_address)	
end

15.times do |m|
	Menu.create(:restaurant_id => Faker::Number.between(1, 5), :name => Faker::Lorem.word , :summary => Faker::Lorem.sentence)
end

15.times do |f|
	FoodItem.create(:menu_id => Faker::Number.between(1, 15), :name =>  Faker::SlackEmoji.food_and_drink,:price => Faker::Commerce.price , :category_id => Faker::Number.between(1, 10))
end

15.times do |m|
	Post.create(:title => Faker::Company.name, :status => Faker::Lorem.sentence , :user_id => Faker::Number.between(1, 3))
end

5.times do |m|
	Checkin.create(:address => Faker::Address.street_address, :post_id => Faker::Number.between(1, 15))
end

5.times do |m|
	Review.create(:title => Faker::Company.name, :summary => Faker::Lorem.sentence , :rating => Faker::Number.between(1, 5) , :reviewable_id => Faker::Number.between(1, 5) , :reviewable_type => 'Restaurant' , :reviewer_id => 1)
end

5.times do |m|
	Review.create(:title => Faker::Company.name, :summary => Faker::Lorem.sentence , :rating => Faker::Number.between(1, 5) , :reviewable_id => 1 , :reviewable_type => 'User' , :reviewer_id => 1)
end

