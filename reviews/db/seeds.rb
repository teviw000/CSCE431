# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

#   Character.create(name: 'Luke', movie: movies.first)
reviews = [ {:name => "Ryan's House", :city => "College Station", :country => "United States", :review => 5, :cost=> 3, :description => "The illest, chillest, ACEST place around", :tags => "ill, chill, ace, food", :phone => "9407044716"},
  {:name => "Zach's Home", :city => "Austin", :country => "United States", :review => 5, :cost => 5, :description => "It was very ok", :tags => "art", :phone => 1112223333d},
  {:name => "Tylor's Oar", :city => "Bryan", :country => "United States", :review => 5, :cost => 2, :description => "The owner's name is spelled wrong", :tags "boat, fun, chilll", :phone => 1231231234},
  {:name => "Viwat Tea's", :city => "Romaine", :country => "Lettuce", :review => 1; :cost => 5, :description => "I got romaine hearts instead.", :tags => "chill, green, good", :phone => 4204206969}
]	

reviews.each do |review|
  Review.create!(review)
end
