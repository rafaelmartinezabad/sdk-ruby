require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetAdvanceAuthorization

  def getAdvanceAuthorization( oNimbleAPI, code )
    oNimbleAPI.authorize( code )
    return {
    	"access_token" => oNimbleAPI.getAccessToken,
    	"refresh_token" => oNimbleAPI.getRefreshToken
    }
  end

end