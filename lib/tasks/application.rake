namespace :application do

  desc "Copy india_rank nil from DumpSite to SeedSite"
  task copy_dump_nil_site: :environment do
  	puts "rake task started..."
  	DumpSite.where("india_rank is NULL").find_each do |site|
  		SeedSite.kreate(site[:name], 0)
  	end
  	puts "rake task ends..."
  end

  desc "Crawl Alexa"
  task alexa_crawl: :environment do
  	puts "Crawling starts..."
  	begin
	  	while SeedSite.count > 0
	  		current_site = SeedSite.order(:score).first.name
	  		if !(SiteInfo.record_exists?(current_site) || DumpSite.record_exists?(current_site))
	  			content = SiteInfo.new.crawl_site(current_site)
	  			india_rank, sites = parse_site_data(content)
	  			if india_rank.present? && india_rank != 0
	  				if india_rank < 10000
	  					SiteInfo.kreate(current_site, india_rank)
	  				else
	  					DumpSite.kreate(current_site, india_rank)
	  				end
	  				sites.each do |site|
	  					if !SiteInfo.record_exists?(site) && !DumpSite.record_exists?(site)
	  						if !SeedSite.record_exists?(site)
	  							SeedSite.kreate(site, india_rank)
	  						else
	  							record = SeedSite.where(name: site).first
	  							if india_rank < record.score
	  								record.score = india_rank
	  								record.save
	  							end
	  						end
	  					end
	  				end
	  			else
	  				DumpSite.kreate(current_site, india_rank)
	  			end
	  			sleep_for_some_time
	  		end
	  		SeedSite.where(name: current_site).first.destroy
	  		queue_length = SeedSite.count
	  		converging_factor = SiteInfo.new.converging_factor
	  		puts "Queue length = #{queue_length}  Converging factor = #{converging_factor}"
	  	end
	  rescue => e
	  	raise e
	  end
  	puts "Crawling end..."
  end

  def sleep_for_some_time
  	sleep 1
  	sleep(rand(0..3))
  end

  def parse_site_data content
  	begin
	  	if content.css(".countryRank").css("div").css(".img-inline").attribute("title").text == "India Flag"
	  		india_rank = content.css(".countryRank").css("div").css("strong").text
	  		india_rank = india_rank.split(",").join("").to_i
	  		sites = content.css("#keywords_upstream_site_table").css("a").map{ |t| t.text }
	  		sites += content.css("#audience_overlap_table").css("a").map{ |t| t.text }
	  		return india_rank, sites
	  	else
	  		arr = content.css("#demographics_div_country_table").css("tbody").css("tr").map { |t| [ t.css("td").first.css("a").attribute("href").value == '/topsites/countries/IN', t.css("td").last.css("span").text ] }
	  		found = arr.detect{ |t| t.first == true }
	  		if found.present?
	  			india_rank = found.last.split(",").join("").to_i
	  			sites = content.css("#keywords_upstream_site_table").css("a").map{ |t| t.text }
	  			sites += content.css("#audience_overlap_table").css("a").map{ |t| t.text }
	  			return india_rank, sites
	  		end
	  	end
	rescue => e
		puts "Problem in parsing"
		return nil, []
	end
  end
end
