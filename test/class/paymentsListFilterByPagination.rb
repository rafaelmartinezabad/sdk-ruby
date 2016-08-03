require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class PaymentsListFilterByPagination

  def method( cc, user_tsec, itemReference = nil )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # get user_tsec to advance authorization method => getAdvanceAuthorization.rb
    filters = Array({
      :itemReference => itemReference, 
      :itemsPerPage => 2
    })
    filters.shift if itemReference == nil || itemReference == ""
    return NimbleAPI::Payments.new.paymentsList( oNimbleAPI, user_tsec, filters )
  end

end
