require 'httparty'
require 'json'
require 'addressable/uri'
require 'openssl'

class NimbleAPI
	class Payments
		def sendPayment ( oNimbleAPI, params )

			url = oNimbleAPI.apiUrl("/v2/payments")

			header = {
				'Content-Type' => "application/json",
				'Authorization' => "Tsec #{oNimbleAPI.access_token}"
			}

			body = {
				'amount' => (params['x_amount'].to_f * 100).to_i,
				'currency' => params['x_currency'],
				'paymentSuccessUrl' => callBack( params, oNimbleAPI.key ),
				'paymentErrorUrl' => params['x_url_cancel'],
				'merchantOrderId' => params['x_reference']
			}

			return oNimbleAPI.restApiCall( url, header, "POST", body)
		end

		private
			def callBack ( fields, key )
				ts = Time.now.utc.iso8601
				payload = {
					'x_account_id'        => fields['x_account_id'].split(":")[0],
					'x_reference'         => fields['x_reference'],
					'x_currency'          => fields['x_currency'],
					'x_test'              => fields['x_test'],
					'x_amount'            => fields['x_amount'],
					'x_result'            => "completed",
					'x_gateway_reference' => SecureRandom.hex,
					'x_timestamp'         => ts
				}
				payload['x_signature'] = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), key, payload.sort.join)
				result = {timestamp: ts}
				redirect_url = Addressable::URI.parse(fields['x_url_complete'])
				redirect_url.query_values = payload
				result[:redirect] = redirect_url
				return JSON.parse(result.to_json)['redirect']
			end
	end
end