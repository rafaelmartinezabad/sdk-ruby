require 'rubygems' if RUBY_VERSION < '1.9'

class NimbleAPI
	class Payments
		def sendPayment ( oNimbleAPI, oPayment )

			url = oNimbleAPI.apiUrl("/v2/payments")

			header = {
				'Content-Type' => "application/json",
				'Authorization' => "Tsec #{oNimbleAPI.access_token}"
			}

			return oNimbleAPI.restApiCall( url, header, "POST", oPayment)
		end
	end
end