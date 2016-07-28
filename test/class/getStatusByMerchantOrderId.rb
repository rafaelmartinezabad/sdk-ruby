require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetStatusByMerchantOrderId

  def method( cc, merchantOrderId )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    return NimbleAPI::Payments.new.getStatusByMerchantOrderId( oNimbleAPI, merchantOrderId )
  end

end
