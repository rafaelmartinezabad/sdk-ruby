require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class PaymentDisputes

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
    return NimbleAPI::Payments.new.paymentDisputes( oNimbleAPI, user_tsec, transactionId )
  end

end
