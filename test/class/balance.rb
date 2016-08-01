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
    # get user_tsec to advance authorization method => getAdvanceAuthorization.rb
    return NimbleAPI::Account.new.balance( oNimbleAPI, user_tsec )
  end

end