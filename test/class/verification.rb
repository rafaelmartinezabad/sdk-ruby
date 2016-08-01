require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class Verification

  def method( cc )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    return NimbleAPI::Environment.new.verification( oNimbleAPI )
  end

end