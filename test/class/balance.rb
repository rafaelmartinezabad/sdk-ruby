require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class Balance

  def method( cc, user_tsec )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    return NimbleAPI::Account.new.balance( oNimbleAPI, user_tsec )
  end

end