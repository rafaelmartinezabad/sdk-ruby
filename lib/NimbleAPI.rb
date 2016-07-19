require 'rubygems' if RUBY_VERSION < '1.9'
require 'base64'
require 'net/http'
require 'uri'
require 'json'

class NimbleAPI
	require_relative 'NimbleAPI/config'
	require_relative 'NimbleAPI/auth'
	require_relative 'NimbleAPI/payments'

	attr_reader :access_token

	def initialize( clientId, clientSecret, sandbox = false )
		@sandbox = sandbox
		@access_token = NimbleAPI::Auth.new.getBasicAuthorization( clientId, clientSecret )
	end

	def apiUrl (path = "")
		url_base = NimbleAPI::Config::NIMBLE_API_BASE_URL
		if @sandbox
			url_base = NimbleAPI::Config::NIMBLE_API_BASE_URL_DEMO
		end
		return url_base + path
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