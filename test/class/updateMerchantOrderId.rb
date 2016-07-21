require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class UpdateMerchantOrderId

  def updateMerchantOrderId( oNimbleAPI )
    transactionId = 1000002108
    oMerchantOrderId = {
      "merchantOrderId" => "TEST"
    }
    return NimbleAPI::Payments.new.updateMerchantOrderId( oNimbleAPI, transactionId, oMerchantOrderId )
  end

end