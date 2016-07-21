require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetStatusByMerchantOrderId

  def getStatusByMerchantOrderId( oNimbleAPI )
    merchantOrderId = 1234
    return NimbleAPI::Payments.new.getStatusByMerchantOrderId( oNimbleAPI, merchantOrderId )
  end

end
