require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetOtpUrl

  def method( cc, ticket, back_url )
  	oNimbleAPI = NimbleAPI.new(
  	  cc.clientId,
  	  cc.clientSecret,
      cc.sandbox
    )
    # back_url is a url redirection callback in string format
    # Example: "http://my-ecommerce.com/return"
    # include commas
    return oNimbleAPI.getCashOutUrl( ticket, back_url )
  end

end