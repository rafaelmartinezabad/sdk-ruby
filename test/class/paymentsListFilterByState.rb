require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class PaymentsListFilterByState

  def method( cc, user_tsec )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # get user_tsec to advance authorization method => getAdvanceAuthorization.rb
    filters = Array({
      :state => "ON_HOLD"
    })
    return NimbleAPI::Payments.new.paymentsList( oNimbleAPI, user_tsec, filters )
  end

end
