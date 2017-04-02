module Common
	module HttpHelper

		require 'uri'
		require 'net/http'

		def get_request url
			uri = URI(url)
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Get.new(uri)
			response = http.request(request)
			if response.code == "200"
				status = 200
				if response.content_type == "text/html"
					body = Nokogiri::HTML::Document.parse(response.body) 
				else
					body = Oj.load(response.body)
				end
				return status, body
			else
				raise "Non 200 Resposne -- #{url}"
			end
		end
	end
end
