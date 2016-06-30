require 'rubygems' if RUBY_VERSION < '1.9'
require 'base64'
require 'net/http'
require 'uri'
require 'json'

class NimbleAPI
	class Auth
		def getBasicAuthorization( clientId, clientSecret )
			
			sourcenc = Base64.strict_encode64("#{clientId.to_str}:#{clientSecret.to_str}")
			header = {
			  'Content-Type' => "application/json",
			  'Authorization' => "Basic #{sourcenc}"
			}
			uri = URI.parse(NimbleAPI::Config::OAUTH_URL + "?grant_type=client_credentials&scope=PAYMENT")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true

			request_token = Net::HTTP::Post.new(uri.request_uri, header)
			response_token = http.request(request_token)

			return JSON.parse(response_token.body)['access_token']
		end
	end
end