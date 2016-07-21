require 'rubygems' if RUBY_VERSION < '1.9'
require 'base64'
require 'net/http'
require 'uri'
require 'json'

class NimbleAPI
	class Auth

		def initialize( clientId, clientSecret )
			@clientId = clientId
			@clientSecret = clientSecret
		end

		def getBasicAuthorization
			
			uri = URI.parse(NimbleAPI::Config::OAUTH_URL + "?grant_type=client_credentials&scope=PAYMENT")

			return restAuthCall( uri )
		end

		def getAdvanceAuthorization( code )

			uri = URI.parse(NimbleAPI::Config::OAUTH_URL + "?grant_type=authorization_code&code=#{code}")

			return restAuthCall( uri )
		end

		def restAuthCall( uri = "" )
			sourcenc = Base64.strict_encode64("#{@clientId.to_str}:#{@clientSecret.to_str}")
			header = {
			  'Content-Type' => "application/json",
			  'Authorization' => "Basic #{sourcenc}"
			}
			http = Net::HTTP.new(uri.host, uri.port)
			http.read_timeout = NimbleAPI::Config::TIMEOUT
			http.use_ssl = true
			request_token = Net::HTTP::Post.new(uri.request_uri, header)
			begin
				response_token = http.request(request_token)
				res_body = JSON.parse(response_token.body)
			rescue Exception => msg
				res_body = JSON.parse('{"result": {"code":408, "info": "Request Timeout"}}')
			end
			return res_body
		end
	end
end