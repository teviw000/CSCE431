# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
records = [ {:name => "Ryan's House", :city => "College Station", :country => "United States", :review => 5, :cost=> 3, :latitude => 30.571357, :longitude => -96.319976, :description => "The illest, chillest, ACEST place around", :tags => "ill, chill, ace", :phone => "9407044716"}
]	

records.each do |record|
Record.create!(record)
end