require 'rubygems' if RUBY_VERSION < '1.9'
require 'base64'
require 'net/http'
require 'uri'
require 'json'

class NimbleAPI
	require '../sdk-ruby/lib/NimbleAPI/auth'

	attr_reader :clientId, :clientSecret, :access_token

	def initialize( clientId, clientSecret )
		@clientId = clientId
		@clientSecret = clientSecret
		@access_token = NimbleAPI::Auth.new.getBasicAuthorization( clientId, clientSecret )
	end

	def restApiCall ( url = "", header = {}, method = "", body = {})
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.read_timeout = Config::TIMEOUT
		http.use_ssl = true
		if method == "POST"
			request_payment = Net::HTTP::Post.new(uri.request_uri, header)
		end
		request_payment.body = body.to_s.gsub('=>', ':')
		response_payment = http.request(request_payment)
		return JSON.parse(response_payment.body)
	end
end