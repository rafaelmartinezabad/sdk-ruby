require 'rubygems' if RUBY_VERSION < '1.9'
require 'base64'
require 'net/http'
require 'uri'
require 'json'

class NimbleAPI
	require_relative 'NimbleAPI/config'
	require_relative 'NimbleAPI/auth'
	require_relative 'NimbleAPI/payments'
	require_relative 'NimbleAPI/credentials'

	def initialize( clientId, clientSecret, sandbox = false )
		@sandbox = sandbox
		@clientId = clientId
		@clientSecret = clientSecret
	end

	def getRefreshToken
		return @refresh_token
	end

	def getAccessToken
		if @access_token == nil
			@access_token = ""
			gba = NimbleAPI::Auth.new( @clientId, @clientSecret ).getBasicAuthorization
			if defined? gba['access_token']
				@access_token = gba['access_token']
			end
		end
		return @access_token
	end

	def setAccessToken( access_token )
		@access_token = access_token
	end

	def authorize( code )
		gaa = NimbleAPI::Auth.new( @clientId, @clientSecret ).getAdvanceAuthorization( code )
		@access_token = ""
		@refresh_token = ""
		if defined? gaa['access_token'] && defined? gaa['refresh_token']
			@access_token = gaa['access_token']
			@refresh_token = gaa['refresh_token']			
		end
	end

	def apiUrl (path = "")
		url_base = NimbleAPI::Config::NIMBLE_API_BASE_URL
		if @sandbox == 'true' || @sandbox == true
			url_base = NimbleAPI::Config::NIMBLE_API_BASE_URL_DEMO
		end
		return url_base + path
	end

	def getAuth3Url
		return NimbleAPI::Config::OAUTH3_URL_AUTH + "?client_id=#{@clientId}&response_type=code"
	end

	def restApiCall ( url = "", header = {}, method = "", body = {})
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.read_timeout = NimbleAPI::Config::TIMEOUT
		http.use_ssl = true
		case method
			when "GET"
				request_payment = Net::HTTP::Get.new(uri.request_uri, header)
			when "PUT"
				request_payment = Net::HTTP::Put.new(uri.request_uri, header)
				request_payment.body = body.to_s.gsub('=>', ':')
			else # "POST"
				request_payment = Net::HTTP::Post.new(uri.request_uri, header)
				request_payment.body = body.to_s.gsub('=>', ':')
		end
		begin
			response_payment = http.request(request_payment)
			res_body = JSON.parse(response_payment.body)
		rescue Exception => msg
			res_body = JSON.parse('{"result": {"code":408, "info": "Request Timeout"}}')
		end
		return res_body
	end
end