class SeedSite < ApplicationRecord
	validates	:name,	uniqueness: true, presence: true
	validates	:score,	presence: true, numericality: { only_integer: true }

	def self.record_exists? site_name
		record = SeedSite.where(name: site_name)
		record.present?
	end

	def self.kreate site_name, score
		record = SeedSite.create(name: site_name, score: score)
		record.present?
	end
end
