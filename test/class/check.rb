require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class Check

  def method( cc )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    return NimbleAPI::Credentials.new.check( oNimbleAPI )
  end

end