class NimbleAPI
	class Payments
		def sendPayment ( oNimbleAPI )

			url = NimbleAPI::Config::NIMBLE_API_BASE_URL + "/v2/payments"

			header = {
			  'Content-Type' => "application/json",
			  'Authorization' => "Tsec #{oNimbleAPI.access_token}"
			}

			method = "POST"

			body = {
			  'amount' => 100,
			  'currency' => "EUR",
			  'paymentSuccessUrl' => "http://www.google.es/&q=EXITO",
			  'paymentErrorUrl' => "http://www.google.es/&q=ERROR",
			  'merchantOrderId' => 1234,
			}
			
			return oNimbleAPI.restApiCall( url, header, method, body)
		end
	end
end