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
    # merchantOrderId is a id of merchant Order in String format
    # Example: "1234"
    # include commas
    return NimbleAPI::Payments.new.getStatusByMerchantOrderId( oNimbleAPI, merchantOrderId )
  end

end
