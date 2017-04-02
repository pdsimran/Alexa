# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

SEED_SITES = [
]

SEED_SITES.each do |site|
	record = SeedSite.where(name: site)
	unless record.present?
		SeedSite.create(name: site, score: 0)
	end
end
