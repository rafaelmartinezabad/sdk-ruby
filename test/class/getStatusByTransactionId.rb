require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetStatusByTransactionId

  def method( cc, transactionId )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    return NimbleAPI::Payments.new.getStatusByTransactionId( oNimbleAPI, transactionId )
  end

end
