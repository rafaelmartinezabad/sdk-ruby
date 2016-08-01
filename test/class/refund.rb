require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class Refund

  def method( s, cc, user_tsec, transactionId )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # get user_tsec to advance authorization method => getAdvanceAuthorization.rb
    oRefund = {
      "amount" => 100,
      "concept" => "Shoes",
      "reason" => "REQUEST_BY_CUSTOMER"
    }
    response = NimbleAPI::Payments.new.refund( oNimbleAPI, user_tsec, transactionId, oRefund )
    # if first request
    if response != nil && response['result']['code'] == 428
      # Save ticket and token
      # in this case tokens save in ../tokens file
      response['msg'] = s.saveTokens( "refund", response['data']['ticket'], response['data']['token'], transactionId )
    end
    return response
  end

end