require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class RefreshAdvanceAuthorization

  def method( s, cc, refresh_token )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # get refresh_token to advance authorization method => getAdvanceAuthorization.rb
    oNimbleAPI.refreshToken( refresh_token )
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