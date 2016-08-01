require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class Cashout

  def method( s, cc, user_tsec )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # get user_tsec to advance authorization method => getAdvanceAuthorization.rb
    oCashout = {
      'amount' => {
      	'value' => 1,
        'currency' => 'EUR'
      },
      'concept' => 'mitad de la cuenta'
    }
    response = NimbleAPI::Account.new.cashout( oNimbleAPI, user_tsec, oCashout )
    # if first request
    if response != nil && response['result']['code'] == 428
      # Save ticket and token
      response['msg'] = s.saveTokens( "cashout", response['data']['ticket'], response['data']['token'] )
    end
    return response
  end

end