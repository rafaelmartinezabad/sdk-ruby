require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class UpdateMerchantOrderId

  def method( cc, transactionId, merchantOrderId )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # transactionId and merchantOrderId are a id of transaction and merchant Order in String format
    # Example: 
    #           transactionId = "1100002334"
    #           merchantOrderId = "1234"
    #
    # include commas
    oMerchantOrderId = { "merchantOrderId" => merchantOrderId }
    return NimbleAPI::Payments.new.updateMerchantOrderId( oNimbleAPI, transactionId, oMerchantOrderId )
  end

end