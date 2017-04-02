class SiteInfo < ApplicationRecord

  include Common::HttpHelper

  validates :name, presence: true, uniqueness: true
  validates :india_rank, presence: true, numericality: { only_integer: true }

  def self.record_exists? site_name
    record = SiteInfo.where(name: site_name)
    record.present?
  end

  def self.kreate site_name, india_rank
    record = SiteInfo.create!(name: site_name, india_rank: india_rank)
    record.present?
  end

  def crawl_site site_name
    url = "http://www.alexa.com/siteinfo/#{site_name}"
    puts "fetching data from #{url}..."
    status, body = get_request(url)
    if status == 200
      body
    end
  end

  def converging_factor
    SiteInfo.count - DumpSite.count
  end

  def is_processed site_name
    SiteInfo.where(name: site_name).present? || DumpSite.where(name: site_name).present?
  end
end
