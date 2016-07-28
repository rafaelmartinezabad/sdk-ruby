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
    oMerchantOrderId = {
      "merchantOrderId" => merchantOrderId
    }
    return NimbleAPI::Payments.new.updateMerchantOrderId( oNimbleAPI, transactionId, oMerchantOrderId )
  end

end