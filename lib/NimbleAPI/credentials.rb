require 'rubygems' if RUBY_VERSION < '1.9'

class NimbleAPI
    class Environment
        def verification ( oNimbleAPI )

            url = oNimbleAPI.apiUrl("/check")

            header = {
                'Authorization' => "Tsec #{oNimbleAPI.getAccessToken}"
            }
			
			return oNimbleAPI.restApiCall( url, header, "GET")
        end
    end
end