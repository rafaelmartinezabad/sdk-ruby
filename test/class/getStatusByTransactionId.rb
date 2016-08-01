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
    # transactionId is a id of transaction in String format
    # Example: "1100002334"
    # include commas
    return NimbleAPI::Payments.new.getStatusByTransactionId( oNimbleAPI, transactionId )
  end

end
