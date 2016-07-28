require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetAdvanceAuthorization

  def method( cc, code )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    oNimbleAPI.authorize( code )
    return {
    	"access_token" => oNimbleAPI.getAccessToken,
    	"refresh_token" => oNimbleAPI.getRefreshToken
    }
  end

end