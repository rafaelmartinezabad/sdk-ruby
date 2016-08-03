require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class PaymentDetails

  def method( cc, user_tsec, transactionId )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # get user_tsec to advance authorization method => getAdvanceAuthorization.rb
    # transactionId is a id of transaction in String format
    # Example: "1100002334"
    # include commas
    # if extendedData is true show more information of payment 
    extendedData = true
    return NimbleAPI::Payments.new.paymentDetails( oNimbleAPI, user_tsec, transactionId, extendedData )
  end

end
