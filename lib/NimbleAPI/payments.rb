require 'rubygems' if RUBY_VERSION < '1.9'

class NimbleAPI
	class Payments
		def sendPayment ( oNimbleAPI, oPayment )

			url = oNimbleAPI.apiUrl("/v2/payments")

			header = {
				'Content-Type' => "application/json",
				'Authorization' => "Tsec #{oNimbleAPI.getAccessToken}",
				'Accept-Language' => oNimbleAPI.lang
			}

			return oNimbleAPI.restApiCall( url, header, "POST", oPayment)
		end

		def getStatusByTransactionId( oNimbleAPI, transactionId )

			url = oNimbleAPI.apiUrl("/v2/payments/status/#{transactionId}")

			header = {
				'Content-Type' => "application/json",
				'Authorization' => "Tsec #{oNimbleAPI.getAccessToken}"
			}

			return oNimbleAPI.restApiCall( url, header, "GET")
		end

		def getStatusByMerchantOrderId( oNimbleAPI, merchantOrderId )

			url = oNimbleAPI.apiUrl("/v2/payments/status?merchantOrderId=#{merchantOrderId}")

			header = {
				'Content-Type' => "application/json",
				'Authorization' => "Tsec #{oNimbleAPI.getAccessToken}"
			}		
			
			return oNimbleAPI.restApiCall( url, header, "GET")
		end

		def updateMerchantOrderId( oNimbleAPI, transactionId, oMerchantOrderId )

			url = oNimbleAPI.apiUrl("/v2/payments/#{transactionId}")

			header = {
				'Content-Type' => "application/json",
				'Authorization' => "Tsec #{oNimbleAPI.getAccessToken}"
			}		
			
			return oNimbleAPI.restApiCall( url, header, "PUT", oMerchantOrderId)
		end

		def refund( oNimbleAPI, user_tsec, transactionId, oRefund )

			url = oNimbleAPI.apiUrl("/v2/payments/#{transactionId}/refunds")

            header = {
                'Content-Type' => "application/json",
                'Authorization' => "Tsec #{user_tsec}"
            }
            
            return oNimbleAPI.restApiCall( url, header, "POST", oRefund)
		end
	end
end