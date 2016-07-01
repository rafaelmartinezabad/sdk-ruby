class NimbleAPI
	class Payments
		def sendPayment ( oNimbleAPI, oPayment )

			url = NimbleAPI::Config::NIMBLE_API_BASE_URL + "/v2/payments"

			header = {
			  'Content-Type' => "application/json",
			  'Authorization' => "Tsec #{oNimbleAPI.access_token}"
			}
			
			return oNimbleAPI.restApiCall( url, header, "POST", oPayment)
		end
	end
end