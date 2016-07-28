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
			
			url = NimbleAPI::Config::OAUTH_URL + "?grant_type=client_credentials&scope=PAYMENT"

			return restAuthCall( url )
		end

		def getAdvanceAuthorization( code )

			url = NimbleAPI::Config::OAUTH_URL + "?grant_type=authorization_code&code=#{code}"

			return restAuthCall( url )
		end

		def refreshAdvanceAuthorization( refresh_token )

			url = NimbleAPI::Config::OAUTH_URL + "?grant_type=refresh_token"

			return restAuthCall( url, refresh_token )
		end

		def restAuthCall( url = "", refresh_token = nil )
			sourcenc = Base64.strict_encode64("#{@clientId.to_str}:#{@clientSecret.to_str}")
			header = {
			  'Content-Type' => "application/json",
			  'Authorization' => "Basic #{sourcenc}"
			}
			uri = URI.parse(url)
			http = Net::HTTP.new(uri.host, uri.port)
			http.read_timeout = NimbleAPI::Config::TIMEOUT
			http.use_ssl = true
			request = Net::HTTP::Post.new(uri.request_uri, header)
			if refresh_token != nil
				request.set_form_data("refresh_token" => refresh_token)
			end
			begin
				response = http.request(request)
			rescue Exception => msg
				return nil
			end
			case response
			when Net::HTTPSuccess, Net::HTTPUnauthorized
				return JSON.parse(response.body)
			when Net::HTTPInternalServerError
				return nil
			else
				return nil
			end
		end
	end
end