require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetAuth3Url

  def method( cc )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    return oNimbleAPI.getAuth3Url
  end

end