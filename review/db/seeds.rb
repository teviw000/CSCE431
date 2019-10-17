<<<<<<< HEAD
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
=======
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

records = [	{:PoI => 'McDonalds', :rating => '5', :cost => '1', phoneNum => 1112223333, :city => 'Austin', :state => 'Texas'},
		{:PoI => 'Zachary', :rating => '1', :cost => '2', phoneNum => 3332221111, :city => 'College Station', :state => 'Texas'},
		{:PoI => 'Wendys', :rating => '3', :cost => '2', phoneNum => 1112223344, :city => 'Bryan', :state => 'Texas'},
	]

records.each do |record|
	Record.create!(record)
end
>>>>>>> viwat
