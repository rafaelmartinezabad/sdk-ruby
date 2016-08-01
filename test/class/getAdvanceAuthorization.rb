require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetAdvanceAuthorization

  def method( s, cc, code )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    oNimbleAPI.authorize( code )
    access_token = oNimbleAPI.getAccessToken
    refresh_token = oNimbleAPI.getRefreshToken
    # Remember save Advance Authorization tokens 
    # in this case tokens save in ../session file
    msg = s.saveOAuth3( access_token, refresh_token ) 
    return {
      "access_token" => access_token,
    	"refresh_token" => refresh_token,
      "msg" => msg
    }
  end

end