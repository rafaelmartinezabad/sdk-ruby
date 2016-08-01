require 'rubygems' if RUBY_VERSION < '1.9'

class NimbleAPI
    class Account
        def balance ( oNimbleAPI, user_tsec )

            url = oNimbleAPI.apiUrl("/v2/balance/summary")

            header = {
                'Authorization' => "Tsec #{user_tsec}"
            }
			
			return oNimbleAPI.restApiCall( url, header, "GET")
        end

        def cashout ( oNimbleAPI, user_tsec, oCashout )

            url = oNimbleAPI.apiUrl("/v2/cashout")

            header = {
                'Content-Type' => "application/json",
                'Authorization' => "Tsec #{user_tsec}"
            }
            
            return oNimbleAPI.restApiCall( url, header, "POST", oCashout)
        end
    end
end