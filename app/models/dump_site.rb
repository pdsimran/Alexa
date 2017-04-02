class DumpSite < ApplicationRecord
	validates	:name,	presence: true, uniqueness: true

	def self.record_exists? site_name
		record = DumpSite.where(name: site_name)
		record.present?
	end

	def self.kreate site_name, india_rank = nil
		record = DumpSite.create!(name: site_name, india_rank: india_rank)
		record.present?
	end
end
